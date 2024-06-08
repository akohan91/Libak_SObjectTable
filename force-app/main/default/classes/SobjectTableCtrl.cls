/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Controller class for managing SObject Table functionality.
 * This class provides methods for initializing SObject Table data.
 */
public with sharing class SobjectTableCtrl {

	/**
	 * Factory method for creating an instance of the specified SobjectTableService.
	 * 
	 * @param serviceName the name of the SobjectTableService to instantiate
	 * @param inputDataJSON the JSON input data for constructing the service
	 * @return the created SobjectTableService instance
	 * @throws SobjectTableException if the service or constructor is not found
	 */
	private static SobjectTableService serviceInstance(String serviceName, String inputDataJSON) {
		if (serviceName == null) {
			throw new SobjectTableException('SObject Table service ' + serviceName + ' not found.');
		}
		String constructorName = serviceName + '.Constructor';
		Type constructorType = Type.forName(constructorName);

		if (constructorType == null) {
			throw new SobjectTableException('Constructor ' + constructorName + ' not found.');
		}
		return ((SobjectTableService.IConstructable)constructorType.newInstance())
			.construct(inputDataJSON);
	}

	/**
	 * Initializes the SObject Table with the specified service and input data.
	 * 
	 * @param serviceName the name of the SobjectTableService to use for initialization
	 * @param inputDataJSON the JSON input data for initializing the SObject Table
	 * @return a map containing initialized SObject Table data
	 * @throws SobjectTableException if an error occurs during initialization
	 */
	@AuraEnabled
	public static Map<String, Object> init(String serviceName, String inputDataJSON){
		try {
			SobjectTableService sobjectTableService = serviceInstance(serviceName, inputDataJSON);
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

	/**
	 * Exception class for SObject Table related exceptions.
	 */
	public class SobjectTableException extends Exception {}
}
