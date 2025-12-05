public class TicketSimParamsStable extends SimParams {

    public TicketSimParamsStable() {
        super();

        name = "TicketStable";

        // esempio: probabilità costanti tipo quelle di NMT Simulation 1
        newCreatorCreationDist = uniform(0.0001);
        creatorPolicyUpdateDist = uniform(0.0001);
        newAssetsCreationDist = uniform(0.001);
        ownerPolicyUpdateDist = uniform(0.0001);
        attributeUpdateDist = uniform(0.001);
        assetTransferDist = uniform(0.001);

        // qui metti i costi di gas specifici per il tuo smart contract Ticket
        C_NMTDeployment = 1292537;  // approx. average gas cost: pub event ticket mint (including deployment of mutable asset)
        C_creatorPolicyUpdate = 496366;  // approx. average deployment cost of CreatorSmartPolicy for Event Ticket
        C_newAssetsCreation = 1292537;  // reuse mint total gas as per Table 5.4 (includes policy eval + asset deployment)
        C_ownerPolicyUpdate = 318518;   // approx. average deployment cost of HolderSmartPolicy (Event Ticket)
        C_attributeUpdate = 100596;     // approx. gas for setValidationDate() + policy eval (representative attribute update)
        C_transfer = 95997;             // approx. gas for transferFrom() on PUB Event Ticket Mutable Asset
    }
}