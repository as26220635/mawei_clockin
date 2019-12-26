package cn.kim.common.mybatis;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;

/**
 * Created by 余庚鑫 on 2019/12/26
 */
class DummyReadWriteLock implements ReadWriteLock {

    private Lock lock = new cn.kim.common.mybatis.DummyReadWriteLock.DummyLock();

    @Override
    public Lock readLock() {
        return lock;
    }

    @Override
    public Lock writeLock() {
        return lock;
    }

    static class DummyLock implements Lock {

        @Override
        public void lock() {
            // Not implemented
        }

        @Override
        public void lockInterruptibly() throws InterruptedException {
            // Not implemented
        }

        @Override
        public boolean tryLock() {
            return true;
        }

        @Override
        public boolean tryLock(long paramLong, TimeUnit paramTimeUnit) throws InterruptedException {
            return true;
        }

        @Override
        public void unlock() {
            // Not implemented
        }

        @Override
        public Condition newCondition() {
            return null;
        }
    }

}
