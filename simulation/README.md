# NMT Simulation

## Panoramica

Questo progetto contiene una simulazione Monte Carlo per modellare il consumo di gas dei contratti smart NMT (Non-Fungible Token Management) su diverse blockchain. La simulazione analizza vari scenari di utilizzo per stimare i costi operativi e verificare la fattibilità su diverse piattaforme blockchain.

## Scopo

La simulazione modella il consumo di gas per le seguenti operazioni:

- **Creazione di nuovi creator**: Gas consumato quando un nuovo creator si registra nel sistema
- **Creazione di nuovi asset**: Gas per il minting di nuovi NFT
- **Aggiornamento policy holder**: Gas per modificare le policy dei possessori di asset
- **Aggiornamento caratteristiche**: Gas per modificare gli attributi degli asset
- **Trasferimenti**: Gas per il trasferimento di asset tra utenti
- **Aggiornamento policy creator**: Gas per modificare le policy dei creator

La simulazione confronta i risultati con i limiti di gas di diverse blockchain:
- **Ethereum**: ~2.5M gas/sec
- **Binance Smart Chain**: ~46.7M gas/sec
- **Optimism Mainnet**: ~30M gas/sec
- **Polygon PoS**: ~15M gas/sec

## Struttura del Progetto

### File Principali

#### `NMTSimulation.java`
Il motore principale della simulazione. Esegue simulazioni Monte Carlo con i seguenti metodi chiave:
- `main()`: Punto di ingresso, configura ed esegue le simulazioni
- `runSimSpaceOptimisedAggregated()`: Esegue la simulazione con aggregazione temporale
- `runSimSpaceOptimised()`: Esegue la simulazione senza aggregazione

#### Configurazioni dei Parametri

Diverse classi `SimParams*.java` definiscono scenari di simulazione:

- **`SimParams.java`**: Classe base con parametri di default
- **`SimParams1.java` - `SimParams4.java`**: Configurazioni con diversi pattern di utilizzo
- **`SimParams5Scaled.java`**: Scenario "Single peak" - crescita graduale con picco singolo
- **`SimParams6Scaled.java`**: Scenario "Boom and bust" - crescita rapida seguita da declino
- **`SimParamsEvent.java`**: Parametri per eventi specifici
- **`SimParamsJacket.java`**: Configurazione alternativa

Ogni classe definisce:
- Costi in gas per ogni operazione (`GAS*` methods)
- Funzioni di probabilità per ogni evento (`PROB*` methods)

#### Funzioni di Probabilità

Le distribuzioni di probabilità modellano quando gli eventi si verificano nel tempo:

- **`ProbabilityFunction.java`**: Interfaccia base
- **`UniformProbDistr.java`**: Distribuzione uniforme (probabilità costante)
- **`ExponentialProbDistr.java`**: Distribuzione esponenziale
- **`ExponentialProbDistrScaled.java`**: Versione scalata
- **`NormalProbDistr.java`**: Distribuzione normale (gaussiana)
- **`NormalProbDistrScaled.java`**: Versione scalata
- **`LognormalProbDistr.java`**: Distribuzione log-normale
- **`LognormalProbDistrScaled.java`**: Versione scalata

#### Gestione Risultati

- **`SimRoundResults.java`**: Raccoglie e aggrega i risultati di ogni round di simulazione
- **`SimRoundResultsAggregated.java`**: Versione ottimizzata con aggregazione temporale
- **`Entity.java`**: Rappresenta creator e asset con timestamp di creazione

## Come Usare

### Prerequisiti

- Java Development Kit (JDK) 8 o superiore
- (Opzionale) gnuplot per la visualizzazione dei risultati

### Compilazione

```bash
# Dalla directory simulation/nmtsimulation
javac *.java
```

### Esecuzione

```bash
# Esegui la simulazione con i parametri di default
java nmtsimulation.NMTSimulation
```

### Configurazione Parametri

Per modificare i parametri della simulazione, edita il file `NMTSimulation.java`:

```java
int NUMRUNS = 10;        // Numero di run Monte Carlo
int MAXTIME = 1209600;   // Durata simulazione in secondi (2 settimane)
int NUMAGGR = 60;        // Granularità aggregazione (60 = minuti)
String dir = "./";       // Directory output

// Scegli lo scenario
SimParams simToRun = new SimParams5Scaled();  // o SimParams6Scaled, etc.
```

### Output

La simulazione genera file TSV (Tab-Separated Values) con il seguente formato:

```
time	gasTotalMean	gasTotalStd	gasNewCreatorMean	gasNewCreatorStd	...
```

**Colonne:**
- `time`: Timestamp in secondi
- `gasTotalMean`: Media del gas totale consumato
- `gasTotalStd`: Deviazione standard del gas totale
- `gasNewCreatorMean/Std`: Statistiche per creazione creator
- `gasNewAssetMean/Std`: Statistiche per creazione asset
- `gasHolderPolicyUpdateMean/Std`: Statistiche per aggiornamenti policy holder
- `gasCharacteristicUpdateMean/Std`: Statistiche per aggiornamenti caratteristiche
- `gasTransferMean/Std`: Statistiche per trasferimenti
- `TotalNumCreators`, `maxCreators`, `minCreators`, `avgCreators`, `stdCreators`: Statistiche sui creator
- `TotalNumAssets`, `maxAssets`, `minAssets`, `avgAssets`, `stdAssets`: Statistiche sugli asset

### Visualizzazione

Usa lo script `doplotAll1Aggr2weeksFINAL.sh` nella directory parent per generare grafici:

```bash
cd ..
bash doplotAll1Aggr2weeksFINAL.sh
```

Lo script genera grafici PNG che mostrano:
- Consumo di gas totale con varianza
- Numero di creator nel tempo
- Numero di asset nel tempo
- Breakdown delle operazioni
- Confronto tra scenari

## Scenari Principali

### SimParams5Scaled - "Single Peak"
Modella una crescita organica con un picco di attività:
- Distribuzione normale per la probabilità degli eventi
- Crescita graduale fino a un massimo, poi declino
- Simula un lancio di successo con adozione crescente

### SimParams6Scaled - "Boom and Bust"
Modella una crescita esplosiva seguita da declino:
- Pattern più volatile
- Picco più alto e rapido
- Simula hype iniziale seguito da normalizzazione

## Personalizzazione

### Creare un Nuovo Scenario

1. Crea una nuova classe che estende `SimParams`:

```java
public class SimParamsCustom extends SimParams {
    public int GASdeployNMT(){ return 2466753;}
    public int GASnewAssetsCreation(){ return 1025897;}
    public ProbabilityFunction PROBnewAssetsCreation(){ 
        return new NormalProbDistrScaled(100, 10, 0.04, 4);
    }
    // ... altri parametri
}
```

2. Modifica `NMTSimulation.java` per usare la nuova configurazione:

```java
SimParams simToRun = new SimParamsCustom();
```

### Modificare le Distribuzioni di Probabilità

Le distribuzioni controllano quando gli eventi si verificano:

- **Uniform**: Probabilità costante nel tempo
- **Normal**: Picco intorno a un tempo medio
- **Exponential**: Decadimento esponenziale
- **Lognormal**: Distribuzione asimmetrica con coda lunga

Parametri comuni:
- `mean`: Tempo medio del picco (per Normal/Lognormal)
- `variance`: Ampiezza della distribuzione
- `rate`: Tasso di decadimento (per Exponential)
- `scale`: Fattore di scala per versioni Scaled

## Note Tecniche

- La simulazione usa `ThreadLocalRandom` per efficienza nelle generazioni random
- L'aggregazione temporale riduce l'uso di memoria per simulazioni lunghe
- I risultati sono calcolati come media e deviazione standard su multiple run Monte Carlo
- Il modello è ottimizzato per spazio (space-optimised) per gestire simulazioni di settimane

## Autori

- Damiano DFM
- brodo
