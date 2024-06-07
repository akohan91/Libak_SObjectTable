/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * The class is used as a service for the SobjectTableCtrl class.
 *
 * Properties of SobjectTableService class:
 * @property sobjectName    { String }
 * @property selectFields   { List<String> }
 * @property conditionBlock { DynamicSOQLConditionBlock }
 * @property orderBy        { DynamicSOQLOrderBy }
 * @property limitRecords   { Integer }
 * @property offsetRecords  { Integer }
 *
 */
public with sharing class SobjectTableServiceDefault extends SobjectTableService {

	public class Constructor implements SobjectTableService.IConstructable {
		public SobjectTableService construct(String inputJSON) {
			return (SobjectTableService)JSON.deserialize(inputJSON, SobjectTableServiceDefault.class);
		}
	}

	/* PUBLIC METHODS */

	


	public class SobjectTableServiceDefaultException extends Exception {}
}
