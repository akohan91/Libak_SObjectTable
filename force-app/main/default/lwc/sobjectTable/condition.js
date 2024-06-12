/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 */
export class Condition {
	/**
	 * @description Sobject field name. Also it could be a path like Account.Name
	 * @type String
	 */
	fieldName;
	/**
	 * @description SOQL confition operator
	 * @type String
	 */
	operator;
	/**
	 * @description Value of SOQL condition
	 * @type String
	 */
	value;
	/**
	 * @description Array of values that is used for 'IN', 'NOT IN', 'INCLUDES', 'EXCLUDES' operators
	 * @type Array
	 */
	values;

	/**
	 *
	 * @param { String } fieldName
	 * @param { String } operator
	 * @param { Any } value
	 */
	constructor(fieldName, operator, value = 'null') {
		this._setFieldNameOrFunction(fieldName);
		this.operator = operator;
		this._setValue(value);
	}

	_setFieldNameOrFunction(fieldName) {
		if (fieldName !== null) {
			this.fieldName = fieldName;
		} else {
			throw new Error('The Field Name in the condition cannot be null.');
		}
	}

	_setValue(value) {
		if (Array.isArray(value)) {
			this.values = value;
		} else if (value instanceof Date && !isNaN(value)) {
			this.value = value;
		} else if (value === null) {
			this.value = 'null';
		} else {
			this.value = value;
		}
	}
}