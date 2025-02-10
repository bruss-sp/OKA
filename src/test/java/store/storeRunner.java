package store;

import com.intuit.karate.junit5.Karate;

class storeRunner {
    @Karate.Test
    Karate testStoreApi() {
        return Karate.run("store").relativeTo(getClass());
    }
}
