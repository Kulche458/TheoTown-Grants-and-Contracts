# Grants & Contracts

This plugin introduces various structured monetary contracts and grants offered by the government, private agencies, and organizations. Each contract provides a completion reward, along with an optional advance payment or a cancellation fee. Goals range from constructing key buildings to reaching population, income, or happiness targets, giving the game a clearer gameplay path.

## Current features
- Accept various contracts with advance payments and completion rewards
- Cancel contracts you no longer want to work towards
- Define custom contracts via JSON, no Lua knowledge necessary
- Contracts support various requirement and goal types (population, buildings, income, city rank, etc.)

## Planned features
- Additional requirement and goal types

## Changelog
A list of major changes to the public version will be kept up to date here.
There is no public version yet.

## Defining custom contracts
This section goes over the details necessary to define functioning contracts of your own.

### Basic syntax
Contracts are defined entirely through JSON. An example contract can be defined as follows:
```json
{
  "id": "$contract_example_00",
  "type": "data",
  "index": true, // Make sure to index contract drafts!
  "meta": {
    "tags": {
      "contract": {}
    },
    "contract id": "$contract_example_00", // This is the internal contract ID. It does not need to match with the ID of the parent draft, but preferably should.
    "title id": "$contract_example_00_title", // The title of the contract, stored in an outside draft. Optionally use "title": "Example contract" to provide a title directly.
    "text id": "$contract_example_00_text", // The description of the contract, stored in an outside draft. Optionally use "text": "Example description" to provide a description directly.
    "advance": 1000, // An optional advance payment granted when accepting the contract.
    "completion": 5000, // An optional (but preferably present) completion payment granted when fulfilling the contract's goals.
    "cancellation": 500, // An optional cancellation fee deducted when cancelling the contract. The advance payment has to be repaid as well when cancelling a contract.
    "requirements": { // Requirements for accepting the contract should be stored here. See below for extra information.
      "rank": 2
    },
    "goals": { // Goals for completing the contract should be stored here. See below for extra information.
      "buildings": [
        {"id": "$building_id_00"}
      ]
    }
  }
}
```

### Contract requirements
All requirements listed in the `"requirements"` object have to be fulfilled to accept the contract. Currently available requirement types are:
```json
"requirements": {
  "rank": 3,
  "contracts completed": ["$contract_example_00"] // Multiple contract IDs can be provided here.
}
```

### Contract goals
All goals listed in the `"goals"` object have to be fulfilled to complete the contract. Currently available goal types are:
```json
"goals": {
  "buildings": [
    {"id": "$building_id_00", "count": 4} // At least "count" buildings of ID "id" have to be built. "count" is optional and 1 by default.
  ],
  "roads": [
    {"id": "$road_id", "count": 50} // Same as above, but for road type drafts.
  ],
  "population": [
    {"count": 500, "level": 1} // At least "count" population of wealth level "level" must be present. "level" is optional, in that case "count" refers to the entire population of the city.
  ],
  "happiness": [
    {"type": "park", "value": 0.6} // At least "value" happiness of type "type" must be achieved. "type" is not optional (for now).
  ],
  "income": 3000 // At least this much monthly income is necessary. Since multiple income goals would be pointless, this one is not an array.
}
```
