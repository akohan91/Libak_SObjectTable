public interface ISObjectTableSOQL {
	ISObjectTableSOQL withField(String fieldPath);
	ISObjectTableSOQL withFunction(SobjectTableService.SOQLFunction soqlFunction);
	ISObjectTableSOQL withConditions(SobjectTableService.ConditionBlock conditionBlock);
	ISObjectTableSOQL withOrderBy(SobjectTableService.OrderBy orderBy);
	ISObjectTableSOQL withLimit(Integer limitRecords);
	ISObjectTableSOQL withOffset(Integer offsetRecords);
	String stringify();
}