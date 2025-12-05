USE DeviceConfiguration;

DECLARE @groupId BIGINT = -7094567047859310012;

EXEC [template].[Template_GetConfigurationGroupsOtherColumns] @groupId = @groupId; --17s
--EXEC [template].[Template_GetConfigurationGroupsOtherColumns_FW] @groupId = @groupId; --22s
--EXEC [template].[Template_GetConfigurationGroupsOtherColumns_Claude] @groupId = @groupId; --17s
--EXEC [template].[Template_GetConfigurationGroupsOtherColumns_Gemini] @groupId = @groupId; --4s

--SELECT TOP 10 * FROM template.ConfigurationGroups tcg WHERE tcg.ConfigurationGroupId IN (1989001888637459309, 3813205176926613669)
