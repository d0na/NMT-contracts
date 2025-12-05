public class ChorSimParams extends SimParams {

        public ChorSimParams() {
            super();

            name = "ChorStable";

            // Stessa forma di "stable interest" del caso Ticket:
            // tutti gli eventi hanno probabilità uniforme nel tempo.
            // Semantica:
            // - newCreatorCreation    ~ nuovi partecipanti / coreografie che entrano nel sistema
            // - creatorPolicyUpdate   ~ aggiornamento policy lato creatore (ente che definisce la coreografia)
            // - newAssetsCreation     ~ nuove istanze di coreografia / partecipante
            // - ownerPolicyUpdate     ~ aggiornamento policy lato holder (ente che detiene il ruolo)
            // - attributeUpdate       ~ update del modello BPMN (messaggi, partecipanti, ecc.)
            // - assetTransfer         ~ trasferimento di ruoli / istanze (es. cambio fornitore)
            newCreatorCreationDist   = uniform(0.0001);
            creatorPolicyUpdateDist  = uniform(0.0001);
            newAssetsCreationDist    = uniform(0.001);
            ownerPolicyUpdateDist    = uniform(0.0001);
            attributeUpdateDist      = uniform(0.001);
            assetTransferDist        = uniform(0.001);

            // --- Gas costs ---
            // Qui ho inizializzato i costi con valori nello stesso ordine di grandezza
            // del caso Event Ticket (per avere subito una simulazione ragionevole).
            // Quando vuoi essere super-preciso puoi sostituirli con i valori
            // ricavati dalla section 6.4.2 + Table 6.2 (canteen scenario).
            C_NMTDeployment       = 1_300_000;  // costo setup iniziale: deploy NMT + primi asset chiave
            C_creatorPolicyUpdate = 500_000;    // deploy/update di CreatorSmartPolicy per coreografia/partecipante
            C_newAssetsCreation   = 1_300_000;  // nuova istanza (Choreography/Participant Mutable Asset)
            C_ownerPolicyUpdate   = 320_000;    // HolderSmartPolicy (ente che gestisce un ruolo)
            C_attributeUpdate     = 100_000;    // update di attributi BPMN (messaggi, partecipanti, ecc.)
            C_transfer            = 100_000;    // trasferimento di ruolo/istanza (es. cambio fornitore)
        }
    }