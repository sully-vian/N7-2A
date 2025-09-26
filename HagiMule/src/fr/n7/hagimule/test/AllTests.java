package fr.n7.hagimule.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
        TestDiaryImpl.class,
        TestHost.class
})
public class AllTests {

}