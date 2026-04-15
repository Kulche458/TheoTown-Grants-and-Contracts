
-- This module handles contract definitions extracted from json data.

local Assets = require('assets')

local Definitions = {}

local contract_definitions = {}

-- Load all defined contracts.
function Definitions.load()
    Draft.getDrafts():forEach(function(draft)
        local meta = draft:getMeta()
        if meta and meta.tags and meta.tags.contract and draft:isPrivileged() then
            local def = Definitions.normalize(meta)
            contract_definitions[def.id] = def
        end
    end)
end

-- Helper function to return internal happiness type fields instead of string names.
function Definitions.getHappinessType(name)
    local types = {
        ['education'] = City.HAPPINESS_EDUCATION,
        ['environment'] = City.HAPPINESS_ENVIRONMENT,
        ['fire department'] = City.HAPPINESS_FIREDEPARTMENT,
        ['free time'] = City.HAPPINESS_FREETIME,
        ['general'] = City.HAPPINESS_GENERAL,
        ['health'] = City.HAPPINESS_HEALTH,
        ['level'] = City.HAPPINESS_LEVEL,
        ['park'] = City.HAPPINESS_PARK,
        ['police'] = City.HAPPINESS_POLICE,
        ['religion'] = City.HAPPINESS_RELIGION,
        ['sport'] = City.HAPPINESS_SPORT,
        ['supply'] = City.HAPPINESS_SUPPLY,
        ['taxes'] = City.HAPPINESS_TAXES,
        ['transport'] = City.HAPPINESS_TRANSPORT,
        ['waste'] = City.HAPPINESS_WASTE,
        ['zone'] = City.HAPPINESS_ZONE
    }

    return types[name]
end

-- Set contract properties to default values if they haven't been explicitly stated.
function Definitions.normalize(meta)
    local contract = {}

    for k, v in pairs(meta) do
        contract[k] = v
    end

    contract.id = contract['contract id']

    contract.advance = contract['advance'] or 0
    contract.completion = contract['completion'] or 0
    contract.cancellation = contract['cancellation'] or 0

    local issuerType = contract.issuer
    contract.issuer = {type = issuerType}
    contract.issuer.icon = Icon.SETTINGS

    if issuerType == 'government' then
        contract.issuer.title = TheoTown.translate('$contracts_string_issuer_government')
        contract.issuer.icon = Assets.FRAMES.ISSUER_GOVERNMENT
    elseif issuerType == 'ngo' then
        contract.issuer.title = TheoTown.translate('$contracts_string_issuer_ngo')
        contract.issuer.icon = Assets.FRAMES.ISSUER_NGO
    elseif issuerType == 'corporate' then
        contract.issuer.title = TheoTown.translate('$contracts_string_issuer_corporate')
        contract.issuer.icon = Assets.FRAMES.ISSUER_CORPORATE
    elseif issuerType == 'elite' then
        contract.issuer.title = TheoTown.translate('$contracts_string_issuer_elite')
        contract.issuer.icon = Assets.FRAMES.ISSUER_ELITE
    elseif issuerType == 'locals' then
        contract.issuer.title = TheoTown.translate('$contracts_string_issuer_locals')
        contract.issuer.icon = Assets.FRAMES.ISSUER_LOCALS
    end

    contract.title = contract['title'] or TheoTown.translate(contract['title id']) or 'title'
    contract.text = contract['text'] or TheoTown.translate(contract['text id']) or 'text'

    contract.requirements = contract['requirements'] or {}
    contract.goals = contract['goals'] or {}

    contract.requirements.rank = contract.requirements['rank']
    contract.requirements.contracts_completed = contract.requirements['contracts completed']
    contract.requirements.income = contract.requirements['income']
    contract.requirements.money = contract.requirements['money']

    if contract.goals.buildings then
        for _, b in ipairs(contract.goals.buildings) do
            b.count = b['count'] or 1
        end
    end

    if contract.goals.roads then
        for _, r in ipairs(contract.goals.roads) do
            r.count = r['count'] or 1
        end
    end

    if contract.goals.population then
        for _, p in ipairs(contract.goals.population) do
            p.level = p['level']
        end
    end

    if contract.goals.happiness then
        for _, h in ipairs(contract.goals.happiness) do
            h.type = h['type']
            h.value = h['value'] or 1
        end
    end

    contract.goals.income = contract.goals['income']
    contract.goals.money = contract.goals['money']

    return contract
end

-- Return a contract definition with provided ID.
function Definitions.get(id)
    return contract_definitions[id]
end

-- Return all contract definitions.
function Definitions.getAll()
    return contract_definitions or {}
end

return Definitions
