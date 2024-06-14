/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Lightning Web Component representing an Sobject Table.
 * 
 * This component provides an interface for displaying Sobject records in a table format with customizable columns
 * and sorting options.
 */

import { LightningElement, api } from 'lwc'
import { flattenForDataTable, overrideDataTableColumns } from './sobjectTableUtils'
import { Condition } from './condition';
import { ConditionBlock } from './conditionBlock'
import { OrderBy } from './orderBy'
import init from '@salesforce/apex/SobjectTableCtrl.init'

export {
	Condition,
	ConditionBlock,
	OrderBy,
}

export default class SobjectTable extends LightningElement {
	/**
	 * The name of the Apex controller that can override default (Apex implementation required).
	 * @type {string}
	 */
	@api serviceName;

	/**
	 * The name of the Sobject to fetch records from.
	 * @type {string}
	 */
	@api sobjectName;

	/**
	 * The fields to be selected from the Sobject.
	 * Can be a comma-separated string or an array.
	 * @type {(string|string[])}
	 */
	@api get selectFields() { return this._selectFields; }
	set selectFields(value) {
		try {
			if (value) {
				this._selectFields = Array.isArray(value) ? value : value.replace(/[\s]/g, '').split(',');
			}
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * The SOQL condition block to filter records.
	 * @type {ConditionBlock}
	 */
	@api conditionBlock = null;

	/**
	 * The maximum number of records to fetch.
	 * Default is 10.
	 * @type {number}
	 */
	@api limitRecords = 10;

	/**
	 * The field to sort records by.
	 * @type {string}
	 */
	@api sortedBy;

	/**
	 * The direction of sorting (asc or desc).
	 * @type {string}
	 */
	@api sortedDirection;

	/**
	 * The columns to override or add to the table.
	 * {
	 * 	action: { String}, 'ADD' | 'REMOVE' | 'OVERRIDE'
	 * 	fieldName: { String }, name of field (column), used for 'REMOVE' and 'OVERRIDE' actions
	 * 	column: { Object }, used for 'ADD' and 'OVERRIDE' actions
	 * }
	 * @type {Object[]}
	 */
	@api columnsToOverride;

	/**
	 * Indicates whether to hide the checkbox column for row selection.
	 * Default is false.
	 * @type {boolean}
	 */
	@api hideCheckboxColumn = false;

	/**
	 * The selected rows in the table.
	 * @type {Object[]}
	 */
	@api selectedRows = [];

	_selectFields;
	recordsCount = 0;
	offsetRecords = 0;
	records;
	dataTableColumns;
	isBusy = true;

	get show() {
		try {
			return {
				content: this.records && this.dataTableColumns,
				spinner: this.isBusy,
			}
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	get orderBy() {
		try {
			return this.sortedBy && 
				new OrderBy([this.sortedBy], this.sortedDirection === 'desc') || 
				null;
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * Refreshes the table by re-fetching data.
	 */
	@api refresh() {
		this.initSobjectTable();
	}

	/**
	 * Paginates the data by setting the offset and limit.
	 * 
	 * @param {number} offset The offset for fetching records.
	 * @param {number} limit The maximum number of records to fetch.
	 */
	@api paginate(offset, limit) {
		try {
			this.offsetRecords = offset;
			this.limitRecords = limit;
			this.initSobjectTable();
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * Initializes the Sobject table by fetching data from the Apex controller.
	 */
	connectedCallback() {
		this.initSobjectTable();
	}

	/**
	 * Initializes the Sobject table by fetching data from the Apex controller.
	 */
	async initSobjectTable() {
		try {
			this.busy();
			let {
				records,
				dataTableColumns,
				recordsCount,
				referenceFieldPaths,
				addressFieldPaths,
			} = await init({
				serviceName: this.serviceName,
				inputData: {
					sobjectName:    this.sobjectName,
					selectFields:   this.selectFields,
					conditionBlock: this.conditionBlock,
					orderBy:        this.orderBy,
					offsetRecords:  this.offsetRecords,
					limitRecords:   this.limitRecords,
				}
			});

			this.records = records.map(record => flattenForDataTable(record, addressFieldPaths, referenceFieldPaths));
			this.recordsCount = recordsCount;
			this.dataTableColumns = overrideDataTableColumns(dataTableColumns, this.columnsToOverride);
			this.sendLoadedEvent(this.records, this.recordsCount);
		} catch (error) {
			this.sendErrorEvent(error);
		} finally {
			this.ready();
		}
	}

	/**
	 * Sets the isBusy flag to true to indicate that the component is busy.
	 */
	busy = () => (this.isBusy = true);

	/**
	 * Sets the isBusy flag to false to indicate that the component is ready.
	 */
	ready = () => (this.isBusy = false);

	/**
	 * Handles sorting events by updating the sortedBy and sortedDirection properties and re-fetching data.
	 * @param {CustomEvent} event - The sort event.
	 */
	handleSort(event) {
		try {
			this.sortedBy = event.detail.columnKey;
			this.sortedDirection = event.detail.sortDirection;
			this.initSobjectTable();
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * Dispatches a custom event indicating that data has been loaded.
	 * 
	 * @param {Array} records An array containing the loaded records.
	 * @param {number} recordsCount The total count of records.
	 */
	sendLoadedEvent(records, recordsCount) {
		const event = new CustomEvent('load', { detail: { records, recordsCount } });
		this.dispatchEvent(event);
	}


	/**
	 * Dispatches row action events by dispatching a custom rowaction event.
	 * @param {CustomEvent} event - The row action event.
	 */
	sendRowActionEvent(event) {
		try {
			this.dispatchEvent(new CustomEvent('rowaction', { detail: {...event.detail} }))
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * Dispatches row selection events by dispatching a custom rowselection event.
	 * @param {CustomEvent} event - The row selection event.
	 */
	sendRowSelectionEvent(event) {
		try {
			this.dispatchEvent(new CustomEvent('rowselection', { detail: {...event.detail} }))
		} catch (error) {
			this.sendErrorEvent(error);
		}
	}

	/**
	 * Dispatches an error event with error details.
	 * 
	 * @param {Object} error The error object containing error details.
	 */
	sendErrorEvent(error) {
		this.dispatchEvent(new CustomEvent('error', { detail: error }))
	}
}