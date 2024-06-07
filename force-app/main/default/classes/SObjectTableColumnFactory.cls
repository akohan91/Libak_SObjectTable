public virtual class SObjectTableColumnFactory {
	public static final Map<Schema.DisplayType, Type> DISPLAY_TYPE_TO_FACTORY_TYPE = new Map<Schema.DisplayType, Type>{
		Schema.DisplayType.ID =>            Reference.class,
		Schema.DisplayType.REFERENCE =>     Reference.class,
		Schema.DisplayType.ADDRESS =>       SObjectTableColumnFactory.class,
		Schema.DisplayType.ANYTYPE =>       SObjectTableColumnFactory.class,
		Schema.DisplayType.BASE64 =>        SObjectTableColumnFactory.class,
		Schema.DisplayType.BOOLEAN =>       SObjectTableColumnFactory.class,
		Schema.DisplayType.COMBOBOX =>      SObjectTableColumnFactory.class,
		Schema.DisplayType.CURRENCY =>      SObjectTableColumnFactory.class,
		Schema.DisplayType.DATE =>          SObjectTableColumnFactory.class,
		Schema.DisplayType.DATETIME =>      SObjectTableColumnFactory.class,
		Schema.DisplayType.DOUBLE =>        SObjectTableColumnFactory.class,
		Schema.DisplayType.EMAIL =>         SObjectTableColumnFactory.class,
		Schema.DisplayType.INTEGER =>       SObjectTableColumnFactory.class,
		Schema.DisplayType.MULTIPICKLIST => SObjectTableColumnFactory.class,
		Schema.DisplayType.PERCENT =>       SObjectTableColumnFactory.class,
		Schema.DisplayType.PHONE =>         SObjectTableColumnFactory.class,
		Schema.DisplayType.PICKLIST =>      SObjectTableColumnFactory.class,
		Schema.DisplayType.STRING =>        SObjectTableColumnFactory.class,
		Schema.DisplayType.TEXTAREA =>      SObjectTableColumnFactory.class,
		Schema.DisplayType.TIME =>          SObjectTableColumnFactory.class,
		Schema.DisplayType.URL =>           SObjectTableColumnFactory.class
	};
	
	private final Map<Schema.DisplayType, String> DISPLAY_TYPE_TO_DATATABLE_TYPE_MAP = new Map<Schema.DisplayType, String>{
		Schema.DisplayType.ID =>            'text',
		Schema.DisplayType.REFERENCE =>     'text',
		Schema.DisplayType.ADDRESS =>       'text',
		Schema.DisplayType.ANYTYPE =>       'text',
		Schema.DisplayType.BASE64 =>        'text',
		Schema.DisplayType.BOOLEAN =>       'boolean',
		Schema.DisplayType.COMBOBOX =>      'text',
		Schema.DisplayType.CURRENCY =>      'currency',
		Schema.DisplayType.DATE =>          'date',
		Schema.DisplayType.DATETIME =>      'date',
		Schema.DisplayType.DOUBLE =>        'number',
		Schema.DisplayType.EMAIL =>         'email',
		Schema.DisplayType.INTEGER =>       'number',
		Schema.DisplayType.MULTIPICKLIST => 'text',
		Schema.DisplayType.PERCENT =>       'percent',
		Schema.DisplayType.PHONE =>         'phone',
		Schema.DisplayType.PICKLIST =>      'text',
		Schema.DisplayType.STRING =>        'text',
		Schema.DisplayType.TEXTAREA =>      'text',
		Schema.DisplayType.TIME =>          'date',
		Schema.DisplayType.URL =>           'url'
	};

	virtual public SObjectTableColumn build(ISObjectTableFieldPath fieldPath) {
		return new SObjectTableColumn(
			fieldPath.path(),
			fieldPath.targetFieldDescribe().getLabel(),
			this.dataTableTypeFromDisplayType(fieldPath.targetFieldDescribe().getType())
		).withColumnKey(fieldPath.path())
		.withSortable(fieldPath.targetFieldDescribe().isSortable());
	}

	virtual protected String dataTableTypeFromDisplayType(Schema.DisplayType type) {
		return DISPLAY_TYPE_TO_DATATABLE_TYPE_MAP.containsKey(type) ?
			DISPLAY_TYPE_TO_DATATABLE_TYPE_MAP.get(type) :
			'text';
	}
	
	public class Reference extends SObjectTableColumnFactory {
		override public SObjectTableColumn build(ISObjectTableFieldPath fieldPath) {
			return new SObjectTableColumn(
				fieldPath.targetReferencePath() + '_link',
				fieldPath.targetFieldDescribe().getLabel(),
				this.dataTableTypeFromDisplayType(Schema.DisplayType.URL)
			).withtypeAttributes(new Map<String, Object>{
				'label' => new Map<String, Object>{'fieldName' => fieldPath.path()},
				'tooltip' => new Map<String, Object>{'fieldName' => fieldPath.path()}
			}).withColumnKey(fieldPath.path())
			.withSortable(fieldPath.targetFieldDescribe().isSortable());
		}
	}
}
