public with sharing class SObjectTableConstants {
	private static final Map<Schema.DisplayType, String> DISPLAY_TYPE_TO_DATATABLE_TYPE_MAP = new Map<Schema.DisplayType, String>{
		Schema.DisplayType.id =>            'text',
		Schema.DisplayType.address =>       'text',
		Schema.DisplayType.anytype =>       'text',
		Schema.DisplayType.base64 =>        'text',
		Schema.DisplayType.Boolean =>       'boolean',
		Schema.DisplayType.Combobox =>      'text',
		Schema.DisplayType.Currency =>      'currency',
		Schema.DisplayType.Date =>          'date',
		Schema.DisplayType.DateTime =>      'date',
		Schema.DisplayType.Double =>        'number',
		Schema.DisplayType.Email =>         'email',
		Schema.DisplayType.Integer =>       'number',
		Schema.DisplayType.MultiPicklist => 'text',
		Schema.DisplayType.Percent =>       'percent',
		Schema.DisplayType.Phone =>         'phone',
		Schema.DisplayType.Picklist =>      'text',
		Schema.DisplayType.String =>        'text',
		Schema.DisplayType.TextArea =>      'text',
		Schema.DisplayType.Time =>          'date',
		Schema.DisplayType.URL =>           'url'
	};
}