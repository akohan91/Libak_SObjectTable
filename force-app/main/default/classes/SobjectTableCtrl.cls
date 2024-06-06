/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 */
public with sharing class SobjectTableCtrl {

	/* FACTORY METHOD */

	private static SobjectTableService controllerInstance(String serviceName, String inputDataJSON) {
		if (serviceName == null) {
			throw new SobjectTableException('SObject Table service ' + serviceName + ' not found.');
		}
		String constructorName = serviceName + '.Constructor';
		Type constructorType = Type.forName(constructorName);

		if (constructorType == null) {
			throw new SobjectTableException('Constructor ' + constructorName + ' not found.');
		}
		return ((SobjectTableService.IConstructable)constructorType.newInstance()).construct(inputDataJSON);
	}

	/* PUBLIC METHODS */

	@AuraEnabled
	public static Map<String, Object> init(String serviceName, String inputDataJSON){
		try {
			SobjectTableService sobjectTableService = controllerInstance(serviceName, inputDataJSON);
			return new Map<String, Object>{
				'records'             => sobjectTableService.tableRows(),
				'recordsCount'        => sobjectTableService.recordsCount(),
				'referenceFieldPaths' => sobjectTableService.referenceFieldPaths(),
				'addressFieldPaths'   => sobjectTableService.addressFieldPaths(),
				'dataTableColumns'    => sobjectTableService.dataTableColumns()
			};
		} catch (Exception exc) {
			throw new SobjectTableException(exc.getMessage());
		}
	}

	public class SobjectTableException extends Exception {}
}
