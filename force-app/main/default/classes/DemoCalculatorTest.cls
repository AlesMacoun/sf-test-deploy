@isTest
private class DemoCalculatorTest {
    @isTest
    static void testAdd() {
        Integer result = DemoCalculator.add(2, 3);
        System.assertEquals(5, result, 'Součet 2+3 musí být 5');
    }

    @isTest
    static void testSubtract() {
        Integer result = DemoCalculator.subtract(10, 4);
        System.assertEquals(6, result, 'Rozdíl 10-4 musí být 6');
    }
}
