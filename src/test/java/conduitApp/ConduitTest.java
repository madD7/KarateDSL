package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

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

}
