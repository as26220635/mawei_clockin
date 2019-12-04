package cn.kim.service.impl;

import cn.kim.common.eu.NameSpace;
import cn.kim.service.AchievementSearchService;
import cn.kim.util.PinyinUtil;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.log4j.Log4j2;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.tokenattributes.OffsetAttribute;
import org.apache.lucene.analysis.tokenattributes.TermAttribute;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.Reader;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by 余庚鑫 on 2019/12/4
 * 成就墙搜索管理
 */
@Service
@Log4j2
public class AchievementSearchServiceImpl extends BaseServiceImpl implements AchievementSearchService {

    /**
     * // 需要参与模糊搜索的字段和最后需要显示的字段 如本次需求需要模糊搜索的字段为name、pinyin、pinyinHead 剩余字段不参与模糊搜索，仅为需要返回给前端显示的字段
     */
    private static final String[] QUERY_FIELD = {"name", "pinyin", "pinyinHead", "id"};

    private static IndexSearcher indexSearcher = null;

    private static IndexReader reader = null;

    private static final String REGEX_NO = "^[0-9]\\w*$";

    private static final String REGEX_CHAR = "^[a-zA-Z]*";

    private static final int RESULT_COUNT = 100000;

    private static Directory ramdDrectory = new RAMDirectory();

    private final Lock writerLock = new ReentrantLock();

    private volatile IndexWriter writer = null;

    private Analyzer analyzer = new Analyzer() {
        @Override
        public TokenStream tokenStream(
                String fileName,
                Reader reader) {
            return new SearchTokenizer(reader);
        }
    };

    public IndexWriter getIndexWriter(Directory dir, IndexWriterConfig config) {
        if (null == dir) {
            throw new IllegalArgumentException("Directory can not be null.");
        }
        if (null == config) {
            throw new IllegalArgumentException("IndexWriterConfig can not be null.");
        }
        try {
            if (null == writer) {
                if (IndexWriter.isLocked(dir)) {
                    //throw new LockObtainFailedException("Directory of index had been locked.");
                    IndexWriter.unlock(dir);
                }
                writer = new IndexWriter(dir, config);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
        }
        return writer;
    }

    @Override
    public void init() throws Exception {
        log.info(" init search method index() ");
        List<Map<String, Object>> list = baseDao.selectList(NameSpace.MainImageMapper, "selectMobileSearchData");

        if (list == null || list.isEmpty()) return;

        IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_36, analyzer);
        try {
            writerLock.lock();
            getIndexWriter(ramdDrectory, config);
            writer.deleteAll();

            Document doc = null;
            String pinyin = null;
            String pinyinHead = null;
            for (Map<String, Object> searchData : list) {
                String ID = toString(searchData.get("ID"));
                String BA_NAME = toString(searchData.get("BA_NAME"));
                //根据name生成对应的全拼
                pinyin = PinyinUtil.getChineseByPinYin(BA_NAME).toLowerCase();
                //根据name生成对应的拼音首字母
                pinyinHead = PinyinUtil.getPinYinHeadChar(BA_NAME).toLowerCase();
                //为每个字段赋值，根据自己需求展示对应字段 与上面数组对应即可, Field.Store和Field.Index具体的含义见下面解释
                doc = new Document();
                doc.add(new Field(QUERY_FIELD[0], BA_NAME, Field.Store.YES, Field.Index.ANALYZED));
                doc.add(new Field(QUERY_FIELD[1], pinyin, Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(QUERY_FIELD[2], pinyinHead, Field.Store.YES, Field.Index.NOT_ANALYZED));
                doc.add(new Field(QUERY_FIELD[3], ID, Field.Store.YES, Field.Index.NOT_ANALYZED));
                writer.addDocument(doc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            writer.close();
            writer = null;
            writerLock.unlock();
        }
    }

    @Override
    public JSONArray search(String queryWord) throws Exception {
        JSONArray searchDataList = new JSONArray();
        indexSearcher = getIndexSearcher(reader);
        if (indexSearcher == null) {
            return searchDataList;
        }
        Query query = null;
        PhraseQuery phrase = null;
        PrefixQuery prefix = null;
        BooleanQuery blquery = null;
        QueryParser parser = null;
        MultiFieldQueryParser multiParser = null;
        TermQuery term = null;
        String[] multiQueryField = {QUERY_FIELD[0]};
        if (queryWord.matches(REGEX_NO)) {
            queryWord = queryWord.toLowerCase();
            // code搜索
            phrase = new PhraseQuery();
            phrase.setSlop(0);
            for (int i = 0; i < queryWord.length(); i++) {
                phrase.add(new Term(QUERY_FIELD[2], Character.toString(queryWord.charAt(i))));
            }
            query = phrase;
        } else if (queryWord.matches(REGEX_CHAR)) {
            // 拼音搜索
            prefix = new PrefixQuery(new Term(QUERY_FIELD[1], queryWord.toLowerCase()));
            query = new WildcardQuery(new Term(QUERY_FIELD[2], queryWord.toLowerCase() + "*"));
            term = new TermQuery(new Term(QUERY_FIELD[0], queryWord.toLowerCase()));
            blquery = new BooleanQuery();
            blquery.add(prefix, Occur.SHOULD);
            blquery.add(query, Occur.SHOULD);
            blquery.add(term, Occur.SHOULD);
            query = blquery;
        } else {
            multiParser = new MultiFieldQueryParser(Version.LUCENE_36, multiQueryField, analyzer);
            parser = multiParser;
            parser.setDefaultOperator(QueryParser.Operator.AND);
            query = parser.parse(QueryParser.escape(queryWord));
        }
        log.info("query param is : " + query.toString());
        // start time
        TopScoreDocCollector collector = TopScoreDocCollector.create(RESULT_COUNT, false);
        long start = new Date().getTime();
        indexSearcher.search(query, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;
        JSONObject searchData = null;
        for (ScoreDoc scoreDoc : hits) {
            Document doc = indexSearcher.doc(scoreDoc.doc);
            searchData = new JSONObject();
            searchData.put(QUERY_FIELD[0], doc.get(QUERY_FIELD[0]));
            searchData.put(QUERY_FIELD[1], doc.get(QUERY_FIELD[1]));
            searchData.put(QUERY_FIELD[2], doc.get(QUERY_FIELD[2]));
            searchData.put(QUERY_FIELD[3], doc.get(QUERY_FIELD[3]));
            searchDataList.add(searchData);
        }
        // end time
        long end = new Date().getTime();
        log.info("Found " + collector.getTotalHits() + " document(s) (in "
                + (end - start) + " millindexSearchereconds) that matched query '"
                + queryWord + "':"
        );
        return searchDataList;
    }

    /**
     * 获取索引
     *
     * @param reader
     * @return
     */
    private IndexSearcher getIndexSearcher(
            IndexReader reader) {
        try {
            if (reader == null) {
                reader = IndexReader.open(ramdDrectory);
            } else {
                //如果当前reader在打开期间index发生改变,则打开并返回一个新的IndexReader,否则返回null
                IndexReader ir = IndexReader.openIfChanged(reader);
                if (ir != null) {
                    reader.close();
                    reader = ir;
                }
            }
            return new IndexSearcher(reader);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //发生异常则返回null
        return null;
    }

    final class SearchTokenizer extends Tokenizer {
        private final TermAttribute termAtt = addAttribute(TermAttribute.class);
        private final OffsetAttribute offsetAtt = addAttribute(OffsetAttribute.class);

        private int pos;

        public SearchTokenizer(Reader input) {
            super(input);
        }

        @Override
        public final boolean incrementToken() throws IOException {
            clearAttributes();

            while (true) {
                int c = input.read();
                if (c == -1) return false;
                // 只处理数字、字母、汉字
                if (Character.isDigit(c) || Character.isLetter(c) || (c >= 19968 && c <= 171941)) {
                    termAtt.setTermBuffer(Character.isLetter(c) ? String.valueOf((char) c).toLowerCase() : String.valueOf((char) c));
                    termAtt.setTermLength(1);
                    offsetAtt.setOffset(correctOffset(pos++), correctOffset(pos));
                    return true;
                }

                pos += Character.charCount(c);
            }
        }

        @Override
        public final void end() throws IOException {
            super.end();
            int finalOffset = correctOffset(pos);
            offsetAtt.setOffset(finalOffset, finalOffset);
        }

        @Override
        public final void reset() throws IOException {
            pos = 0;
        }
    }
}
