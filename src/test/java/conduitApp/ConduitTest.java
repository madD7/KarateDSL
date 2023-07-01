package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

/** Our Karate Runner Class. */
class ConduitTest {

    @Test
    void testParallel() {

        /** Classpath must be set to where runner is located & other tests will be located.
         * Classpath starts from inside 'src\test\java'.
         */
        Results results = Runner.path("classpath:conduitApp")   
                //.outputCucumberJson(true)
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    /**
     * Copied from: https://github.com/karatelabs/karate#junit-5
     * Compare to understand modifications done.
     */
    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }

    /**
     * Copied from: https://github.com/karatelabs/karate#junit-5
     * Compare to understand modifications done.
     */
    @Karate.Test
    Karate singleTestTags() {
        return Karate.run().tags("@SingleTest").relativeTo(getClass());
    }
}
