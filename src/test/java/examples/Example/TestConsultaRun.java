package examples.Example;

import com.intuit.karate.junit5.Karate;

class TestConsultaRun {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("/finance-api/v1/asbanc/debts/query").relativeTo(getClass());
    }

}
