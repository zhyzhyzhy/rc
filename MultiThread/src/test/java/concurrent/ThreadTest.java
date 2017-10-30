package concurrent;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.locks.LockSupport;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

@RunWith(JUnit4.class)
public class ThreadTest {
    @Test
    //Executors中默认有一个ThreadFactory
    public void ConcurrentThreadFactoryTest() {
        ThreadFactory factory = Executors.defaultThreadFactory();
        factory.newThread(() -> System.out.println("hello")).start();
    }

    @Test
    //对象方法级别的synchronized锁住的是this对象
    //holdsLock可以判断当前线程是否拥有参数中对象的锁
    public synchronized void holdsLock1() {
        assertTrue(Thread.holdsLock(this));
    }

    @Test
    //静态方法hold的是class对象
    public void holdsLock3() {
        holdsLock2();
    }
    public static synchronized void holdsLock2() {
        assertTrue(Thread.holdsLock(ThreadTest.class));
    }

    @Test
    public void throwIllegalMonitorStateExceptionTest() {
        try {
            notify();
        } catch (Exception e) {
            assertEquals(e.getClass(), IllegalMonitorStateException.class);
        }
    }


    public enum State {
        /**
         * 还未开始
         */
        NEW,


        /**
         * 分为两种
         * 第一种是可执行状态，在可执行任务列表中，等待被调度执行
         * 一种是正在执行
         */
        RUNNABLE,


        /**
         * 等待一个锁
         */
        BLOCKED,


        /**
         * 调用了Object.wait()方法，没有设置超时
         * 调用了join方法，没有设置超时
         * 调用了LockSupport#park()方法
         *
         * 等在其他线程执行特定的动作
         * 一个wait的线程等待其他线程的notify或者notifyAll
         * 一个join的线程等待其他线程的结束
         */
        WAITING,


        /**
         * 相比较wait，有一个超时
         * 比如Thread.sleep
         * LockSupport#parkUntil
         * LockSupport#parkNanos
         * Object.wait} with timeout
         * Thread.join} with timeout
         */
        TIMED_WAITING,

        /**
         * 一个结束的线程
         */
        TERMINATED;
    }

    @Test
    public void getThreadStat() {
        assertEquals(Thread.State.RUNNABLE, Thread.currentThread().getState());
    }

    @Test
    public void LockSupport() {

        class packMainThread {
            private void packThread() {
                System.out.println("main thread pack!");
                LockSupport.park();
                System.out.println("main thread is unpacked!");
            }
        }

        Thread thread = Thread.currentThread();
        Executors.defaultThreadFactory().newThread(() -> {
            try {
                Thread.sleep(3000);
                System.out.println("unpack main thread!");
                LockSupport.unpark(thread);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }).start();
        new packMainThread().packThread();
    }

}
