# STM-471 Streamax Decommissioning and ReCommissioning

  COMMON | Local | INT | Nuget
  FE | Local | PR DEV
  BE | Local | DEV Nuget | NEEDS INT NUGET!!

  Config/MR/STM-471_STM_Commission_Decommission.21.10.INT.ORI

  STM-471: Decommission and Recommission of STM: WIP

  FE: PR DEV:
  https://dev.azure.com/MiXTelematics/Common/_git/MiX.Fleet.UI/pullrequest/56950

  BE: PR DEV:
  https://mixtelematics.visualstudio.com/Common/_git/DynaMiX.Backend/pullrequest/57318

  MiX.DeviceConfig.Api.Client.2021.11.20210630.1-alpha +

  SN :: 003B0001E1


  - !!! REMOVED THIS CODE:
    ...\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetDetailsModule.cs
    line 343
    if (!string.IsNullOrEmpty(streamaxSerialNumber) || (resolvedMobileDevice.DefinitionDeviceId == MobileDevices.STREAMAX && !string.IsNullOrEmpty(resolvedMobileDevice.UnitIdentifier)))


  - TEST CASES
    [SAVE]
    Standalone > register (if Serial no)

    [CHANGE Mobile Device]
    na Peripheral 
    From Standalone > Deregister

    To Standalone (with peripheral) > Deregister 
      & Register
      To Standalone (no peripheral) > Reg

    [CHANGE Config group]
    Standalone (if SP camera diff) > Deregister 
    & Register

    [REMOVE]
    Standalone > deregister

  - DONE
      1) NEXT - pull in new client from Dewald
      2) CHECK all my todos below...

      changeMobileDeviceTemplate.deviceTypeId: "6183256567829462590"

      var cancelWatch = $scope.$watch('form', function () {
                                angular.setDirty($dynamicScope.assetCommissioningForm);

      $scope.form.mobileDeviceId = $scope.changeMobileDeviceTemplate.deviceTypeId

      mobileDeviceCarrier.DeviceTypeId


  - DONE (but still to test)
    [SAVE]
    Standalone > register (if Serial no)

    [CHANGE Mobile Device]
    na Peripheral
    From Standalone > Deregister

    To Standalone (with peripheral) > Deregister 
      & Register
      To Standalone (no peripheral) > Reg

    [CHANGE Config group]
    Standalone (if SP camera diff) > Deregister 
    & Register

    [REMOVE]
    Standalone > deregister


- Calling these methods...
  
  COMM
  DeviceConfigClient.MobileUnits.CommissionUpdateStreamax(authToken, assetId, propertyValues, true, CorrelationId).ConfigureAwait(false).GetAwaiter().GetResult();

  DECOMM
  DeviceConfigApi.DeviceConfigClient.MobileUnits.DecommissionStreamax(authToken, assetId, CorrelationId).ConfigureAwait(false).GetAwaiter().GetResult();


  - ISSUE

    Communication with the underlying transaction manager has failed

      at System.Transactions.TransactionInterop.GetOletxTransactionFromTransmitterPropigationToken(Byte[] propagationToken)
      at System.Transactions.TransactionStatePSPEOperation.PSPEPromote(InternalTransaction tx)
      at System.Transactions.TransactionStateDelegatedBase.EnterState(InternalTransaction tx)
      at System.Transactions.EnlistableStates.Promote(InternalTransaction tx)
      at System.Transactions.Transaction.Promote()
      at System.Transactions.TransactionInterop.ConvertToOletxTransaction(Transaction transaction)
      at System.Transactions.TransactionInterop.GetExportCookie(Transaction transaction, Byte[] whereabouts)
      at System.Data.SqlClient.SqlInternalConnection.GetTransactionCookie(Transaction transaction, Byte[] whereAbouts)
      at System.Data.SqlClient.SqlInternalConnection.EnlistNonNull(Transaction tx)
      at System.Data.SqlClient.SqlInternalConnection.Enlist(Transaction tx)
      at System.Data.ProviderBase.DbConnectionInternal.ActivateConnection(Transaction transaction)
      at System.Data.ProviderBase.DbConnectionPool.PrepareConnection(DbConnection owningObject, DbConnectionInternal obj, Transaction transaction)
      at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, UInt32 waitForMultipleObjectsTimeout, Boolean allowCreate, Boolean onlyOneCheckConnection, DbConnectionOptions userOptions, DbConnectionInternal& connection)
      at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal& connection)
      at System.Data.ProviderBase.DbConnectionFactory.TryGetConnection(DbConnection owningConnection, TaskCompletionSource`1 retry, DbConnectionOptions userOptions, DbConnectionInternal oldConnection, DbConnectionInternal& connection)
      at System.Data.ProviderBase.DbConnectionInternal.TryOpenConnectionInternal(DbConnection outerConnection, DbConnectionFactory connectionFactory, TaskCompletionSource`1 retry, DbConnectionOptions userOptions)
      at System.Data.SqlClient.SqlConnection.TryOpenInner(TaskCompletionSource`1 retry)
      at System.Data.SqlClient.SqlConnection.TryOpen(TaskCompletionSource`1 retry)
      at System.Data.SqlClient.SqlConnection.Open()
      at DynaMiX.Data.ConfigAdmin.ConfigAdminSqlRepository.DeleteMessageStateHistory(Int64 assetId) in C:\Projects\DynaMiX.Backend\Data\DynaMiX.Data\ConfigAdmin\ConfigAdminSqlRepository.cs:line 996
      at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.DeleteAssetMobileUnit(String authToken, Int64 orgId, Int64 assetId, Boolean overrideAssetActiveState, Nullable`1 decommissionedSiteId, String notes, Int64 correlationId, Boolean calledFromDeviceConfigAPI) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 573
      at DynaMiX.Logic.FleetAdmin.AssetCommissioningManager.ChangeAssetMobileUnit(String authToken, Int64 orgId, Int64 assetId, Int64 newConfigurationGroupId, Int64 correlationId) in C:\Projects\DynaMiX.Backend\Logic\DynaMiX.Logic\FleetAdmin\AssetCommissioningManager.cs:line 627
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.ChangeMobileDevice(String authToken, Int64 orgId, Int64 assetId, AssetChangeMobileDeviceFormCarrier carrier) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 232
      at DynaMiX.Api.NancyModules.FleetAdmin.Assets.AssetCommissioningModule.<.ctor>b__19_3(Object args) in C:\Projects\DynaMiX.Backend\API\DynaMiX.API\NancyModules\FleetAdmin\Assets\AssetCommissioningModule.cs:line 159
      at System.Dynamic.UpdateDelegates.UpdateAndExecute2[T0,T1,TRet](CallSite site, T0 arg0, T1 arg1)
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass49_0.b__2(Object args) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 530
      at DynaMiX.Core.Http.Nancy.ModuleBase.<>c__DisplayClass26_1.b__1() in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 281
      at DynaMiX.Core.Http.Nancy.ModuleBase.ProcessVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 190
      at DynaMiX.Core.Http.Nancy.ModuleBase.HandledVoidResponse(Func`1 method) in C:\Projects\DynaMiX.Backend\Core\DynaMiX.Core.Http\Nancy\ModuleBase.cs:line 120


- Some notes
  
  0837678287

  form.streamaxSerialNumber
  assetChangeStreamaxDeviceTemplate.streamaxSerialNumber
  form.orgIsStreamaxEnabled
  form.deviceIsStreamaxEnabled


  WasStreamax
  WasStreamaxPeripheral


  I saw that there are two IDs for streamax
  MobileDevice.Streamax -1064000195705392069 (Streamax Standalone)
  System.Logical.Streamax 6811245503730565049

  # STM-431

- Saam doen