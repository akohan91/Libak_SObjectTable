@IsTest
public with sharing class MockSObjectTableTestService extends SobjectTableService {

	public MockSObjectTableTestService(SobjectTableService.SObjectTableInputData inputData) {
		super(inputData);
	}

	override protected ISObjectTableSOQLConstructable sObjectTableSOQLConstructor() {
		return new MockSObjectTableSOQLConstructor();
	}
	override protected ISObjectTableFieldPathConstructable sObjectTableFieldPathConstructor() {
		return new MockSObjectTableFieldPathConstructor();
	}

	/**
	 * MOCK SObject Table SOQL
	 */

	public class MockSObjectTableSOQLConstructor implements ISObjectTableSOQLConstructable {
		public ISObjectTableSOQL construct(String sObjectName) {
			return new MockSObjectTableSOQL(sObjectName);
		}
	}

	public class MockSObjectTableSOQL implements ISObjectTableSOQL {
		private String sObjectName;
		private Boolean isCountQuery = true;
		
		public MockSObjectTableSOQL(String sObjectName) {
			this.sObjectName = sObjectName;
		}

		public ISObjectTableSOQL withField(String fieldPath) {
			this.isCountQuery = false;
			return this;
		}
		public ISObjectTableSOQL withFunction(SobjectTableService.SOQLFunction soqlFunction) { return this; }
		public ISObjectTableSOQL withConditions(SobjectTableService.ConditionBlock conditionBlock) { return this; }
		public ISObjectTableSOQL withOrderBy(SobjectTableService.OrderBy orderBy) { return this; }
		public ISObjectTableSOQL withLimit(Integer limitRecords) { return this; }
		public ISObjectTableSOQL withOffset(Integer offsetRecords) { return this; }

		public String stringify() {
			return this.isCountQuery
				? 'SELECT COUNT() FROM ' + this.sObjectName
				: 'SELECT Id FROM ' + this.sObjectName;
		}
	}

	/**
	 * MOCK SObject Table Fiel dPath
	 */

	public class MockSObjectTableFieldPathConstructor implements ISObjectTableFieldPathConstructable {
		public ISObjectTableFieldPath construct(String sObjectName, String fieldPath) {
			return new MockSObjectTableFieldPath(sObjectName, fieldPath);
		}
	}

	public class MockSObjectTableFieldPath implements ISObjectTableFieldPath {
		private String sObjectName;
		private String fieldPath;

		private Map<String, Schema.DescribeFieldResult> fieldToFieldDescribe = new map<String, Schema.DescribeFieldResult>{
			'id'				=> Account.SObjectType.getDescribe().fields.getMap().get('Id').getDescribe(),
			'isdeleted'			=> Account.SObjectType.getDescribe().fields.getMap().get('IsDeleted').getDescribe(),
			'name'				=> Account.SObjectType.getDescribe().fields.getMap().get('Name').getDescribe(),
			'type'				=> Account.SObjectType.getDescribe().fields.getMap().get('Type').getDescribe(),
			'billingstreet'		=> Account.SObjectType.getDescribe().fields.getMap().get('BillingStreet').getDescribe(),
			'billinglatitude'	=> Account.SObjectType.getDescribe().fields.getMap().get('BillingLatitude').getDescribe(),
			'billingaddress'	=> Account.SObjectType.getDescribe().fields.getMap().get('BillingAddress').getDescribe(),
			'phone'				=> Account.SObjectType.getDescribe().fields.getMap().get('Phone').getDescribe(),
			'website'			=> Account.SObjectType.getDescribe().fields.getMap().get('Website').getDescribe(),
			'annualrevenue'		=> Account.SObjectType.getDescribe().fields.getMap().get('AnnualRevenue').getDescribe(),
			'numberofemployees'	=> Account.SObjectType.getDescribe().fields.getMap().get('NumberOfEmployees').getDescribe(),
			'createddate'		=> Account.SObjectType.getDescribe().fields.getMap().get('CreatedDate').getDescribe(),
			'lastactivitydate'	=> Account.SObjectType.getDescribe().fields.getMap().get('LastActivityDate').getDescribe(),
			'owner.name'		=> User.SObjectType.getDescribe().fields.getMap().get('Name').getDescribe()
		};

		public MockSObjectTableFieldPath(String sObjectName, String fieldPath) {
			this.sObjectName = sObjectName;
			this.fieldPath = fieldPath;
		}
		
		public String path() {
			return this.fieldPath;
		}
		public String targetReferencePath() {
			return this.fieldPath == 'Owner.Name' ? 'owner.id' : this.fieldPath;
		}
		public Schema.DescribeFieldResult targetFieldDescribe() {
			return this.fieldToFieldDescribe.get(this.fieldPath);
		}
	}
}