# Grants & Contracts

This plugin introduces various structured monetary contracts and grants offered by the government, private agencies, and organizations. Each contract provides a completion reward, along with an optional advance payment or a cancellation fee. Goals range from constructing key buildings to reaching population, income, or happiness targets, giving the game a clearer gameplay path.

## Current features
- Accept various contracts with advance payments and completion rewards
- Cancel contracts you no longer want to work towards
- Define custom contracts via JSON, no Lua knowledge necessary
- Contracts support various requirement and goal types (population, buildings, income, city rank, etc.)

## Planned features
- Add additional requirement and goal types
- Add contracts menu and controls hotkeys
- Implement failsafe checks for incorrectly implemented contract drafts
- Don't show the menu if all possible contracts have already been completed

## Changelog
A list of major changes to the public version will be kept up to date here.

## Release v1.0
- Released the plugin to the public on official platforms
- Added emergency bailout grants
- Added flavor contract issuers
- Added a cover image
- Improved strings and translations

## Pre-release v0.2
- Fixed contracts were available on the moon
- Added dynamic goal display (can be enabled in the settings)
- Added more contracts
- Slightly adjusted some contract rewards

### Pre-release v0.1
- Initial stable release with most planned features implemented.

## Defining custom contracts
This section goes over the details necessary to define functioning contracts of your own. Contracts can only be defined by privileged plugin creators.

### Basic syntax
Contracts are defined entirely through JSON. An example contract can be defined as follows:
```jsonc
{
  "require privileges": true, // Necessary. The contract won't be loaded otherwise.
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
    "issuer": "government", // An optional issuer field. No gameplay impact, flavor only. Possible issuers are: "government", "ngo", "corporate", "elite", "locals".
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
```jsonc
"requirements": {
  "rank": 3,
  "contracts completed": ["$contract_example_00"], // Multiple contract IDs can be provided here.
  "income": 5000, // Minimum monthly income. Logic is inverted for negative values.
  "money": 5000 // Same as above, but for money at hand. Logic switch also applies.
}
```

### Contract goals
All goals listed in the `"goals"` object have to be fulfilled to complete the contract. Currently available goal types are:
```jsonc
"goals": {
  "buildings": [
    // At least "count" buildings of ID "id" have to be built. "count" is optional and 1 by default.
    // "count" of 0 will only be considered completed if there are exactly 0 buildings in the city.
    {"id": "$building_id_00", "count": 4}
  ],
  "roads": [
    // Same as above, but for road type drafts. "count": 0 rule also applies here.
    {"id": "$road_id", "count": 50}
  ],
  "population": [
    // At least "count" population of wealth level "level" must be present. "level" is optional, in that case "count" refers to the entire population of the city.
    {"count": 500, "level": 1}
  ],
  "happiness": [
    // At least "value" happiness of type "type" must be achieved. "type" is optional.
    {"type": "park", "value": 0.6}
  ],
  "income": 3000, // At least this much monthly income is necessary. Since multiple income goals would be pointless, this one is not an array.
  "money": 3000 // Same as above, but for money at hand.
}
```

## Translations
If you would like to help by translating strings, you can do so by copying the `strings.json` file, renaming it to `strings_xx.json` (where `xx` is the corresponding ISO 639-1 language code), and modifying it like so:
```jsonc
[
  {
    "id": "$kulche_contract_strings_00_xx", // Make sure to change the ID!
    "type": "translation",
    "xx": { // The language code goes here as well!
      // ...
      // Translated strings go here...
      // ...
    }
  }
]
```
Make sure to create a pull request once you're done.  
Thank you if you choose to contribute!

## Credits & legal
Plugin created by Kulche. Special thanks to JustAnyone, PBbunnypower and Lobby. Sound effects derived from Freesound content.  
Translations by flxzor, impieee (Indonesian).  
Cover image derived from city built by DualHD.  
Do not reupload files from this repository anywhere else, or claim them as your own.
