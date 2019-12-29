package cn.kim.util;

import cn.kim.common.attr.AttributePath;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.poi.util.IOUtils;
import org.apache.poi.util.POILogger;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

/**
 * Created by 余庚鑫 on 2017/3/5.
 */
@Log4j2
public class ImageUtil {
    /**
     * 截图工具，根据截取的比例进行缩放裁剪
     *
     * @param path        图片路径
     * @param zoomX       缩放后的X坐标
     * @param zoomY       缩放后的Y坐标
     * @param zoomW       缩放后的截取宽度
     * @param zoomH       缩放后的截取高度
     * @param scaleWidth  缩放后图片的宽度
     * @param scaleHeight 缩放后的图片高度
     * @return 是否成功
     * @throws IOException
     */
    public static boolean imgCut(String path, int zoomX, int zoomY, int zoomW,
                                 int zoomH, int scaleWidth, int scaleHeight) throws IOException {
        Image img;
        ImageFilter cropFilter;
        BufferedImage bi = ImageIO.read(new File(path));
        int fileWidth = bi.getWidth();
        int fileHeight = bi.getHeight();
        double scale = (double) fileWidth / (double) scaleWidth;

        double realX = zoomX * scale;
        double realY = zoomY * scale;
        double realW = zoomW * scale;
        double realH = zoomH * scale;

        if (fileWidth >= realW && fileHeight >= realH) {
            Image image = bi.getScaledInstance(fileWidth, fileHeight, Image.SCALE_DEFAULT);
            cropFilter = new CropImageFilter((int) realX, (int) realY, (int) realW, (int) realH);
            img = Toolkit.getDefaultToolkit().createImage(
                    new FilteredImageSource(image.getSource(), cropFilter));
            BufferedImage bufferedImage = new BufferedImage((int) realW, (int) realH, BufferedImage.TYPE_INT_RGB);
            Graphics g = bufferedImage.getGraphics();
            g.drawImage(img, 0, 0, null);
            g.dispose();
            //输出文件
            return ImageIO.write(bufferedImage, "JPEG", new File(path));
        } else {
            return true;
        }
    }

    /**
     * 添加图片水印
     * 可以过滤正常图片恶意代码
     *
     * @param srcImg   目标图片路径，如：C:\\kutuku.jpg
     * @param waterImg 水印图片路径，如：C:\\kutuku.png
     * @param x        水印图片距离目标图片左侧的偏移量，如果x<0, 则在正中间
     * @param y        水印图片距离目标图片上侧的偏移量，如果y<0, 则在正中间
     * @param alpha    透明度(0.0 -- 1.0, 0.0为完全透明，1.0为完全不透明)
     * @throws IOException
     */
    public static void addWaterMark(String srcImg, String waterImg, int x, int y, float alpha) throws IOException {
        // 加载目标图片
        File file = new File(srcImg);
        String ext = srcImg.substring(srcImg.lastIndexOf(".") + 1);
        Image image = ImageIO.read(file);
        int width = image.getWidth(null);
        int height = image.getHeight(null);

        // 将目标图片加载到内存。
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bufferedImage.createGraphics();
        g.drawImage(image, 0, 0, width, height, null);

        // 加载水印图片。
        Image waterImage = ImageIO.read(new File(waterImg));
        int widthOne = waterImage.getWidth(null);
        int heightOne = waterImage.getHeight(null);
        // 设置水印图片的透明度。
        g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

        // 设置水印图片的位置。
        int widthDiff = width - widthOne;
        int heightDiff = height - heightOne;
        if (x < 0) {
            x = widthDiff / 2;
        } else if (x > widthDiff) {
            x = widthDiff;
        }
        if (y < 0) {
            y = heightDiff / 2;
        } else if (y > heightDiff) {
            y = heightDiff;
        }

        // 将水印图片“画”在原有的图片的制定位置。
        g.drawImage(waterImage, x, y, widthOne, heightOne, null);
        // 关闭画笔。
        g.dispose();

        // 保存目标图片。
        ImageIO.write(bufferedImage, ext, file);
    }

    /**
     * 添加图片水印
     * 可以过滤正常图片恶意代码
     *
     * @param srcImg   目标图片路径，如：C:\\kutuku.jpg
     * @param waterImg 水印图片路径，如：C:\\kutuku.png
     * @param x        水印图片距离目标图片左侧的偏移量，如果x<0, 则在正中间
     * @param y        水印图片距离目标图片上侧的偏移量，如果y<0, 则在正中间
     * @param alpha    透明度(0.0 -- 1.0, 0.0为完全透明，1.0为完全不透明)
     * @throws IOException
     */
    public static ByteArrayOutputStream addWaterMark(InputStream srcImg, InputStream waterImg, int x, int y, float alpha) throws IOException {
        // 加载目标图片
        Image image = ImageIO.read(srcImg);
        int width = image.getWidth(null);
        int height = image.getHeight(null);

        // 将目标图片加载到内存。
        BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bufferedImage.createGraphics();
        g.drawImage(image, 0, 0, width, height, null);

        // 加载水印图片。
        Image waterImage = ImageIO.read(waterImg);
        int widthOne = waterImage.getWidth(null);
        int heightOne = waterImage.getHeight(null);
        // 设置水印图片的透明度。
        g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));

        // 设置水印图片的位置。
//        int widthDiff = (waterWidth != null ? waterWidth : width - widthOne);
//        int heightDiff = (waterHeight != null ? waterHeight : height - heightOne);
//        if (x < 0) {
//            x = widthDiff / 2;
//        } else if (x > widthDiff) {
//            x = widthDiff;
//        }
//        if (y < 0) {
//            y = heightDiff / 2;
//        } else if (y > heightDiff) {
//            y = heightDiff;
//        }

        // 将水印图片“画”在原有的图片的制定位置。
        g.drawImage(waterImage, x, y, widthOne, heightOne, null);
        // 关闭画笔。
        g.dispose();

        // 保存目标图片。
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "PNG", out);

        return out;
    }

    /**
     * 添加背景图片
     *
     * @param baseInputStream
     * @param clockinInputStream
     * @param imgShare
     * @return
     */
    public static MultipartFile addBackgroud(InputStream baseInputStream, InputStream clockinInputStream, Map<String, Object> imgShare) {
        return null;
    }

    /**
     * 添加背景图片
     *
     * @param srcImg
     * @param waterImg
     * @param x
     * @param y
     * @param alpha
     * @return
     * @throws IOException
     */
    public static ByteArrayOutputStream addBackground(BufferedImage image, BufferedImage waterImage, BufferedImage backgroundImage, int waterMaxWidth, int waterMaxHeight, int waterX, int waterY, int backgroundMaxWidth, int backgroundMaxHeight, int backgroundX, int backgroundY) throws IOException {
        // 加载目标图片
        ByteArrayOutputStream out = null;
        try {
            int width = image.getWidth(null);
            int height = image.getHeight(null);

            // 将目标图片加载到内存。
            BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = bufferedImage.createGraphics();
//        // 增加下面代码使得背景变成白色
//        g.setPaint(Color.WHITE);
//        g.setBackground(Color.WHITE);
//        g.clearRect(0, 0, width, height);
//        g.drawLine(0, 0, width, height);
            //补充多余部分背景
            float backgroundRate = getRate(backgroundImage, backgroundMaxWidth, backgroundMaxHeight);
            int backgroundWidth = (int) (backgroundImage.getWidth(null) * backgroundRate);
            int backgroundHeight = (int) (backgroundImage.getHeight(null) * backgroundRate);

            g.drawImage(backgroundImage, backgroundX, backgroundY, backgroundWidth, backgroundHeight, null);

            //添加主要图片
            float waterRate = getRate(waterImage, waterMaxWidth, waterMaxHeight);
            int waterWidth = (int) (waterImage.getWidth(null) * waterRate);
            int waterHeight = (int) (waterImage.getHeight(null) * waterRate);
            g.drawImage(waterImage, waterX, waterY, waterWidth, waterHeight, null);

            //主图片
            g.drawImage(image, 0, 0, width, height, null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER));
            // 关闭画笔。
            g.dispose();

            // 保存目标图片。
            out = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "jpeg", out);

//            ImageOutputStream ios = ImageIO.createImageOutputStream(out);
//            Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("jpeg");
//            ImageWriter writer = iter.next();
//            ImageWriteParam iwp = writer.getDefaultWriteParam();
//            iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
//            iwp.setCompressionQuality(0.8f);
//            writer.setOutput(ios);
//            writer.write(null, new IIOImage(bufferedImage, null, null), iwp);
//            writer.dispose();
        } catch (IOException e) {
            throw e;
        } finally {
            closeQuietly(image);
            closeQuietly(waterImage);
            closeQuietly(backgroundImage);
        }

        return out;
    }

    /**
     * 获取缩放比例
     *
     * @param image
     * @param maxWidth
     * @param maxHeight
     * @return
     */
    public static float getRate(Image image, int maxWidth, int maxHeight) {
        int width = image.getWidth(null);
        int height = image.getHeight(null);
        float rate1 = (float) maxWidth / width;
        float rate2 = (float) maxHeight / height;

        //控制缩放大小
        float rate = Math.min(rate1,rate2);
        return rate;
    }

    /**
     * 获取图片最小比例
     *
     * @param width
     * @param height
     * @param minWith
     * @param minHeight
     * @return
     */
    public static float getMinRate(int width, int height, int minWith, int minHeight) {
        float rate1 = (float) minWith / width;
        float rate2 = (float) minHeight / height;

        float rate = Math.max(rate1,rate2);
        return rate;
    }

    /**
     * 添加文字
     *
     * @param srcImgSteram
     * @param waterMarkContent 水印内容
     * @param x
     * @param y
     * @return
     * @throws IOException
     */
    public static ByteArrayOutputStream addWaterMarkText(InputStream srcImgSteram, String waterMarkContent, int x1, int y1, int x2, int y2) throws IOException {
        Font font = new Font("黑体", Font.PLAIN, 35);
        Color color = new Color(0, 0, 0, 255);
        return addWaterMarkText(srcImgSteram, waterMarkContent, color, font, x1, y1, x2, y2);
    }

    /**
     * 添加文字
     *
     * @param srcImgSteram
     * @param waterMarkContent 水印内容
     * @param markContentColor 水印颜色
     * @param font             水印字体
     * @param x
     * @param y
     * @return
     * @throws IOException
     */
    public static ByteArrayOutputStream addWaterMarkText(InputStream srcImgSteram, String waterMarkContent, Color markContentColor, Font font, int x1, int y1, int x2, int y2) throws IOException {
        int fontSize = font.getSize();
        // 读取原图片信息
        Image srcImg = ImageIO.read(srcImgSteram);//文件转化为图片
        int srcImgWidth = srcImg.getWidth(null);//获取图片的宽
        int srcImgHeight = srcImg.getHeight(null);//获取图片的高
        // 加水印
        BufferedImage bufImg = new BufferedImage(srcImgWidth, srcImgHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bufImg.createGraphics();
        g.drawImage(srcImg, 0, 0, srcImgWidth, srcImgHeight, null);
        g.setColor(markContentColor); //根据图片的背景设置水印颜色
        g.setFont(font);              //设置字体

        // 设置RenderingHints(渲染提示)，以达到文字抗锯齿的功效,(key,value)形式赋值
        RenderingHints rh = new RenderingHints(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        rh.put(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        rh.put(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_LCD_HRGB);
        g.setRenderingHints(rh);

        //设置水印的坐标
        //文字叠加,自动换行叠加
        int tempX = x1;
        int tempY = y1;
        int tempCharLen = 0;//单字符长度
        int tempLineLen = 0;//单行字符总长度临时计算
        StringBuffer stringBuffer = new StringBuffer();
        for (int i = 0; i < waterMarkContent.length(); i++) {
            char tempChar = waterMarkContent.charAt(i);
            tempCharLen = getCharLen(tempChar, g);
            if (tempLineLen + fontSize >= (x2 - x1)) {
                // 绘制前一行+
                g.drawString(stringBuffer.toString(), tempX, tempY);
                //清空内容,重新追加
                stringBuffer.delete(0, stringBuffer.length());
                //文字长度已经满一行,Y的位置加1字符高度
                tempY = tempY + fontSize;
                tempLineLen = 0;
            }
            //追加字符
            stringBuffer.append(tempChar);
            tempLineLen += tempCharLen;
        }
        //最后叠加余下的文字
        g.drawString(stringBuffer.toString(), tempX, tempY);
        g.dispose();

        // 保存目标图片。

        ByteArrayOutputStream out = new ByteArrayOutputStream();

        // 为了保证原质量输出，我们用ImageWriter输出图片
        // 获取ImageWriter对象
        Iterator writers = ImageIO.getImageWritersByFormatName("jpg");
        ImageWriter writer = (ImageWriter) writers.next();
        // 指定输出路径
        ImageOutputStream ios = ImageIO.createImageOutputStream(out);
        // 修改ImageWriteParam，原质量输出图片
        ImageWriteParam imageWriteParam = writer.getDefaultWriteParam();
        imageWriteParam.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
        imageWriteParam.setCompressionQuality(1);
        // 将BufferedImage转换为IIOImage,进而输出图片
        IIOImage iio_image = new IIOImage(bufImg, null, null);
        // 输出
        writer.setOutput(ios);
        writer.write(null, iio_image, imageWriteParam);

//        ImageIO.write(bufImg, "PNG", out);
        return out;
    }

    public static int getCharLen(char c, Graphics2D g) {
        return g.getFontMetrics(g.getFont()).charWidth(c);
    }

    /**
     * 将图片转换成Base64编码
     *
     * @param imgPath 待处理图片
     * @return
     */
    public static String imgToBase64(String imgPath) {
        InputStream in = null;
        byte[] data = null;
        // 读取图片字节数组
        try {
            in = new FileInputStream(imgPath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 对字节数组Base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        // 返回Base64编码过的字节数组字符串
        return encoder.encode(data);
    }

    /**
     * 将图片转换成Base64编码
     *
     * @param out
     * @return
     */
    public static String imgToBase64(ByteArrayOutputStream out) {
        byte[] bytes = out.toByteArray();
        return imgToBase64(bytes);
    }

    /**
     * 将图片转换成Base64编码
     *
     * @param data
     * @return
     */
    public static String imgToBase64(byte[] data) {
        // 对字节数组Base64编码
        BASE64Encoder encoder = new BASE64Encoder();
        // 返回Base64编码过的字节数组字符串
        return encoder.encode(data);
    }

    /**
     * 获取图片宽度
     *
     * @param file 图片文件
     * @return 宽度
     */
    public static int getImgWidth(InputStream file) {
        BufferedImage src = null;
        int ret = -1;
        try {
            src = javax.imageio.ImageIO.read(file);
            ret = src.getWidth(null); // 得到源图宽
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }


    /**
     * 获取图片高度
     *
     * @param file 图片文件
     * @return 高度
     */
    public static int getImgHeight(InputStream file) {
        BufferedImage src = null;
        int ret = -1;
        try {
            src = javax.imageio.ImageIO.read(file);
            ret = src.getHeight(null); // 得到源图高
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    public static InputStream getImageStream(BufferedImage bimage) {
        InputStream is = null;
        ByteArrayOutputStream bs = new ByteArrayOutputStream();
        ImageOutputStream imOut;
        try {
            imOut = ImageIO.createImageOutputStream(bs);
            ImageIO.write(bimage, "png", imOut);
            is = new ByteArrayInputStream(bs.toByteArray());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return is;
    }


    /**
     * 获取远程网络图片信息
     *
     * @param imageURL
     * @return
     */
    public static BufferedImage getRemoteBufferedImage(String imageURL) {
        URL url = null;
        InputStream is = null;
        BufferedImage bufferedImage = null;
        try {
            url = new URL(imageURL);
            is = url.openStream();
            bufferedImage = ImageIO.read(is);
        } catch (MalformedURLException e) {
            e.printStackTrace();
            System.out.println("imageURL: " + imageURL + ",无效!");
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("imageURL: " + imageURL + ",读取失败!");
            return null;
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println("imageURL: " + imageURL + ",流关闭异常!");
                return null;
            }
        }
        return bufferedImage;
    }

    /**
     * 关闭图片
     *
     * @param image
     */
    public static void closeQuietly(final java.awt.Image image) {
        // no need to log a NullPointerException here
        if (image == null || image.getGraphics() == null) {
            return;
        }

        try {
            image.flush();
            image.getGraphics().dispose();
        } catch (Exception exc) {
            log.error("Unable to close resource: " + exc);
        }
    }
}
