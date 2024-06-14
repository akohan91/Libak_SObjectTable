@IsTest
public with sharing class TestSobjectTableService {
	
	@IsTest
	static void testSobjectRecords(){
		SObjectTableService service = new MockSObjectTableTestService(getInputData());

		Test.startTest();

		Assert.areEqual(0, service.tableRows().size(), 'There should be no records returned.');
		
		Test.stopTest();
	}
	
	@IsTest
	static void testRecordsCount(){
		SObjectTableService service = new MockSObjectTableTestService(getInputData());

		Test.startTest();

		Assert.areEqual(0, service.recordsCount(), 'There should be 0.');
		
		Test.stopTest();
	}
	
	@IsTest
	static void testAddressFieldPaths(){
		SObjectTableService service = new MockSObjectTableTestService(getInputData());

		Test.startTest();

		List<String> result = service.addressFieldPaths();
		
		Test.stopTest();

		Assert.areEqual(1, result.size(), 'There should be 1.');
		Assert.areEqual('billingaddress', result.get(0), 'The address field is wrong.');
	}
	
	@IsTest
	static void testReferenceFieldPaths(){
		SObjectTableService service = new MockSObjectTableTestService(getInputData());

		Test.startTest();

		List<String> result = service.referenceFieldPaths();
		
		Test.stopTest();

		Assert.areEqual(3, result.size(), 'The list of reference fields is wrong.');
		Assert.isTrue(result.contains('id'), 'The reference fields should include the id field.');
		Assert.isTrue(result.contains('name'), 'The reference fields should include the name field.');
		Assert.isTrue(result.contains('owner.id'), 'The reference fields should include the owner.id field.');
	}

	@IsTest
	static void testDataTableColumns(){
		SObjectTableService service = new MockSObjectTableTestService(getInputData());

		Test.startTest();

		List<SObjectTableColumn> result = service.dataTableColumns();
		
		Test.stopTest();

		Assert.areEqual(14, result.size(), 'There should be 14 SObject Table Columns.');
		System.debug(JSON.serializePretty(result));
	}

	private static SobjectTableService.SObjectTableInputData getInputData() {
		SobjectTableService.SObjectTableInputData imputData = new SobjectTableService.SObjectTableInputData();
		imputData.sobjectName = 'Account';
		imputData.selectFields = new List<String>{
			'Id',
			'IsDeleted',
			'Name',
			'Type',
			'BillingStreet',
			'BillingLatitude',
			'BillingAddress',
			'Phone',
			'Website',
			'AnnualRevenue',
			'NumberOfEmployees',
			'Owner.Name',
			'CreatedDate',
			'LastActivityDate'
		};
		return imputData;
	}
}