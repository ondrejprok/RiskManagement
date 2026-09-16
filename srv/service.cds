using { BusinessPartnerA2X } from './external/BusinessPartnerA2X.cds';

using { RiskManagement as my } from '../db/schema.cds';

@path : '/service/RiskManagementService'
service RiskManagementService
{
    @cds.redirection.target
    @odata.draft.enabled
    entity Risks as
        projection on my.Risks;

    @cds.redirection.target
    @odata.draft.enabled
    entity Mitigations as
        projection on my.Mitigations;

    @cds.redirection.target
    entity A_BusinessPartner as
        projection on BusinessPartnerA2X.A_BusinessPartner
        {
            BusinessPartner,
            Customer,
            Supplier,
            BusinessPartnerCategory,
            BusinessPartnerFullName,
            BusinessPartnerIsBlocked
        };
}

annotate RiskManagementService with @requires :
[
    'authenticated-user'
];

annotate RiskManagementService.Risks with @restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { grant: '*',    to: 'RiskManager' }
];

annotate RiskManagementService.Mitigations with @restrict: [
    { grant: 'READ', to: 'RiskViewer' },
    { grant: '*',    to: 'RiskManager' }
];