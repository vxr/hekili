-- Constants.lua
-- June 2014

local addon, ns = ...
local Hekili = _G[ addon ]


-- Class Localization
ns.getLocalClass = function ( class )

  if not ns.player.sex then ns.player.sex = UnitSex( 'player' ) end

  return ns.player.sex == 1 and LOCALIZED_CLASS_NAMES_MALE[ class ] or LOCALIZED_CLASS_NAMES_FEMALE[ class ]

end


local InverseDirection = {
  LEFT = 'RIGHT',
  RIGHT = 'LEFT',
  TOP = 'BOTTOM',
  BOTTOM = 'TOP'
}

ns.getInverseDirection = function ( dir )

  return InverseDirection[ dir ] or dir

end


local ClassIDs = {}

for i = 1, GetNumClasses() do
  local classDisplayName, classTag = GetClassInfo( i )

  ClassIDs[ classTag ] = i
end

ns.getClassID = function( class )

  return ClassIDs[ class ] or -1

end


local ResourceInfo = {
    -- health          = Enum.PowerType.HealthCost,
    none            = Enum.PowerType.None,
    mana            = Enum.PowerType.Mana,
    rage            = Enum.PowerType.Rage,
    focus           = Enum.PowerType.Focus,
    energy          = Enum.PowerType.Energy,
    combo_points    = Enum.PowerType.ComboPoints,
    runes           = Enum.PowerType.Runes,
    runic_power     = Enum.PowerType.RunicPower,
    soul_shards     = Enum.PowerType.SoulShards,
    astral_power    = Enum.PowerType.LunarPower,
    holy_power      = Enum.PowerType.HolyPower,
    alternate       = Enum.PowerType.Alternate,
    maelstrom       = Enum.PowerType.Maelstrom,
    chi             = Enum.PowerType.Chi,
    insanity        = Enum.PowerType.Insanity,
    obsolete        = Enum.PowerType.Obsolete,
    obsolete2       = Enum.PowerType.Obsolete2,
    arcane_charges  = Enum.PowerType.ArcaneCharges,
    fury            = Enum.PowerType.Fury,
    pain            = Enum.PowerType.Pain
}

local ResourceByID = {}

for k, powerType in pairs( ResourceInfo ) do
    ResourceByID[ powerType ] = k
end


function ns.GetResourceInfo()
    return ResourceInfo
end


function ns.GetResourceID( key )
    return ResourceInfo[ key ]
end


function ns.GetResourceKey( id )
    return ResourceByID[ id ]
end


local passive_regen = {
    mana = 1,
    focus = 1,
    energy = 1
}

function ns.ResourceRegenerates( key )
    -- Does this resource have a passive gain from waiting?
    if passive_regen[ key ] then return true end
    return false
end


local Specializations = {
  death_knight_blood = 250,
  death_knight_frost = 251,
  death_knight_unholy = 252,

  druid_balance = 102,
  druid_feral = 103,
  druid_guardian = 104,
  druid_restoration = 105,

  hunter_beast_mastery = 253,
  hunter_marksmanship = 254,
  hunter_survival = 255,

  mage_arcane = 62,
  mage_fire = 63,
  mage_frost = 64,

  monk_brewmaster = 268,
  monk_windwalker = 269,
  monk_mistweaver = 270,

  paladin_holy = 65,
  paladin_protection = 66,
  paladin_retribution = 70,

  priest_discipline = 256,
  priest_holy = 257,
  priest_shadow = 258,

  rogue_assassination = 259,
  rogue_outlaw = 260,
  rogue_subtlety = 261,

  shaman_elemental = 262,
  shaman_enhancement = 263,
  shaman_restoration = 264,

  warlock_affliction = 265,
  warlock_demonology = 266,
  warlock_destruction = 267,

  warrior_arms = 71,
  warrior_fury = 72,
  warrior_protection = 73,

  demonhunter_havoc = 577,
  demonhunter_vengeance = 581
}

ns.getSpecializationID = function ( key )
  return Specializations[ key ] or -1
end


local SpecializationKeys = {
  [250] = 'blood',
  [251] = 'frost',
  [252] = 'unholy',

  [102] = 'balance',
  [103] = 'feral',
  [104] = 'guardian',
  [105] = 'restoration',

  [253] = 'beast_mastery',
  [254] = 'marksmanship',
  [255] = 'survival',

  [62] = 'arcane',
  [63] = 'fire',
  [64] = 'frost',

  [268] = 'brewmaster',
  [269] = 'windwalker',
  [270] = 'mistweaver',

  [65] = 'holy',
  [66] = 'protection',
  [70] = 'retribution',

  [256] = 'discipline',
  [257] = 'holy',
  [258] = 'shadow',

  [259] = 'assassination',
  [260] = 'outlaw',
  [261] = 'subtlety',

  [262] = 'elemental',
  [263] = 'enhancement',
  [264] = 'restoration',

  [265] = 'affliction',
  [266] = 'demonology',
  [267] = 'destruction',

  [71] = 'arms',
  [72] = 'fury',
  [73] = 'protection',

  [577] = 'havoc',
  [581] = 'vengeance'
}

ns.getSpecializationKey = function ( id )
  return SpecializationKeys[ id ] or 'none'
end


ns.getSpecializationID = function ( index )
  return GetSpecializationInfo( index or GetSpecialization() or 0 )
end



ns.FrameStratas = {
  "BACKGROUND",
  "LOW",
  "MEDIUM",
  "HIGH",
  "DIALOG",
  "FULLSCREEN",
  "FULLSCREEN_DIALOG",
  "TOOLTIP",

  BACKGROUND = 1,
  LOW = 2,
  MEDIUM = 3,
  HIGH = 4,
  DIALOG = 5,
  FULLSCREEN = 6,
  FULLSCREEN_DIALOG = 7,
  TOOLTIP = 8
}


local controlSpellTypes = {
  ----------------
  -- Demonhunter
  ----------------
  [179057] = "CC",        -- Chaos Nova
  [205630] = "CC",        -- Illidan's Grasp
  [208618] = "CC",        -- Illidan's Grasp (throw stun)
  [217832] = "CC",        -- Imprison
  [221527] = "CC",        -- Imprison (pvp talent)
  [204843] = "Snare",       -- Sigil of Chains
  [207685] = "CC",        -- Sigil of Misery
  [204490] = "Silence",     -- Sigil of Silence
  [211881] = "CC",        -- Fel Eruption
  [200166] = "CC",        -- Metamorfosis stun
  [247121] = "Snare",       -- Metamorfosis snare
  [196555] = "Immune",      -- Netherwalk
  [188499] = "ImmunePhysical",  -- Blade Dance (dodge chance increased by 100%)
  [213491] = "CC",        -- Demonic Trample Stun
  [206649] = "Silence",     -- Eye of Leotheras (no silence, 5% dmg and duration reset for spell casted)
  [232538] = "Snare",       -- Rain of Chaos
  [213405] = "Snare",       -- Master of the Glaive
  [198813] = "Snare",       -- Vengeful Retreat
  [198589] = "Other",       -- Blur
  [212800] = "Other",       -- Blur
  [209426] = "Other",       -- Darkness
  
  ----------------
  -- Death Knight
  ----------------
  [108194] = "CC",        -- Asphyxiate
  [221562] = "CC",        -- Asphyxiate
  [47476]  = "Silence",     -- Strangulate
  [96294]  = "Root",        -- Chains of Ice (Chilblains)
  [45524]  = "Snare",       -- Chains of Ice
  [115018] = "Other",       -- Desecrated Ground (Immune to CC)
  [207319] = "Immune",      -- Corpse Shield (not immune, 90% damage redirected to pet)
  [48707]  = "ImmuneSpell",   -- Anti-Magic Shell
  [51271]  = "Other",       -- Pillar of Frost
  [48792]  = "Other",       -- Icebound Fortitude
  [49039]  = "Other",       -- Lichborne
  [287081] = "Other",       -- Lichborne
  [81256]  = "Other",       -- Dancing Rune Weapon
  [194679] = "Other",       -- Rune Tap
  [152279] = "Other",       -- Breath of Sindragosa
  [207289] = "Other",       -- Unholy Frenzy
  [116888] = "Other",       -- Shroud of Purgatory
  [145629] = "ImmuneSpell",   -- Anti-Magic Zone (not immune, 20%/60% damage reduction)
  [207167] = "CC",        -- Blinding Sleet
  [207165] = "CC",        -- Abomination's Might
  [207171] = "Root",        -- Winter is Coming
  [287254] = "CC",        -- Dead of Winter (pvp talent)
  [210141] = "CC",        -- Zombie Explosion (Reanimation PvP Talent)
  [206961] = "CC",        -- Tremble Before Me
  [248406] = "CC",        -- Cold Heart (legendary)
  [233395] = "Root",        -- Deathchill (pvp talent)
  [204085] = "Root",        -- Deathchill (pvp talent)
  [273977] = "Snare",       -- Grip of the Dead
  [211831] = "Snare",       -- Abomination's Might (slow)
  [200646] = "Snare",       -- Unholy Mutation
  [143375] = "Snare",       -- Tightening Grasp
  [208278] = "Snare",       -- Debilitating Infestation
  [212764] = "Snare",       -- White Walker
  [190780] = "Snare",       -- Frost Breath (Sindragosa's Fury) (artifact trait)
  [191719] = "Snare",       -- Gravitational Pull (artifact trait)
  [204206] = "Snare",       -- Chill Streak (pvp honor talent)
  [334693] = "CC",        -- Absolute Zero (Legendary)
  
    ----------------
    -- Death Knight Ghoul
    ----------------
    [212332] = "CC",        -- Smash
    [212336] = "CC",        -- Smash
    [212337] = "CC",        -- Powerful Smash
    [47481]  = "CC",        -- Gnaw
    [91800]  = "CC",        -- Gnaw
    [91797]  = "CC",        -- Monstrous Blow (Dark Transformation)
    [91807]  = "Root",        -- Shambling Rush (Dark Transformation)
    [212540] = "Root",        -- Flesh Hook (Abomination)
  
  ----------------
  -- Druid
  ----------------
  [33786]  = "CC",        -- Cyclone
  [99]     = "CC",        -- Incapacitating Roar
  [236748] = "CC",        -- Intimidating Roar
  [163505] = "CC",        -- Rake
  [22570]  = "CC",        -- Maim
  [203123] = "CC",        -- Maim
  [203126] = "CC",        -- Maim (pvp honor talent)
  [236025] = "CC",        -- Enraged Maim (pvp honor talent)
  [5211]   = "CC",        -- Mighty Bash
  [2637]   = "CC",        -- Hibernate
  [81261]  = "Silence",     -- Solar Beam
  [339]    = "Root",        -- Entangling Roots
  [235963] = "CC",        -- Entangling Roots (Earthen Grasp - feral pvp talent) -- Also -80% hit chance (CC and Root category)
  [45334]  = "Root",        -- Immobilized (Wild Charge - Bear)
  [102359] = "Root",        -- Mass Entanglement
  [102793] = "Snare",       -- Ursol's Vortex
  [50259]  = "Snare",       -- Dazed (Wild Charge - Cat)
  [61391]  = "Snare",       -- Typhoon
  [127797] = "Snare",       -- Ursol's Vortex
  [232559] = "Snare",       -- Thorns (pvp honor talent)
  [61336]  = "Immune",      -- Survival Instincts (not immune, damage taken reduced by 50%)
  [22842]  = "Other",       -- Frenzied Regeneration
  [332172] = "Other",       -- Frenzied Regeneration
  [332471] = "Other",       -- Frenzied Regeneration
  [132158] = "Other",       -- Nature's Swiftness
  [305497] = "Other",       -- Thorns (pvp honor talent)
  [102543] = "Other",       -- Incarnation: King of the Jungle
  [106951] = "Other",       -- Berserk
  [102558] = "Other",       -- Incarnation: Guardian of Ursoc
  [102560] = "Other",       -- Incarnation: Chosen of Elune
  [117679] = "Other",       -- Incarnation: Tree of Life
  [236696] = "Other",       -- Thorns
  [29166]  = "Other",       -- Innervate
  [22812]  = "Other",       -- Barkskin
  [102342] = "Other",       -- Ironbark
  [202244] = "CC",        -- Overrun (pvp honor talent)
  [209749] = "Disarm",      -- Faerie Swarm (pvp honor talent)
  
  ----------------
  -- Hunter
  ----------------
  [117526] = "Root",        -- Binding Shot
  [1513]   = "CC",        -- Scare Beast
  [3355]   = "CC",        -- Freezing Trap
  [13809]  = "CC",        -- Ice Trap 1
  [195645] = "Snare",       -- Wing Clip
  [19386]  = "CC",        -- Wyvern Sting
  [128405] = "Root",        -- Narrow Escape
  [136634] = "Root",        -- Narrow Escape
  [201158] = "Root",        -- Super Sticky Tar (root)
  [111735] = "Snare",       -- Tar
  [135299] = "Snare",       -- Tar Trap
  [5116]   = "Snare",       -- Concussive Shot
  [194279] = "Snare",       -- Caltrops
  [206755] = "Snare",       -- Ranger's Net (snare)
  [236699] = "Snare",       -- Super Sticky Tar (slow)
  [213691] = "CC",        -- Scatter Shot (pvp honor talent)
  [186265] = "Immune",      -- Aspect of the Turtle
  [189949] = "Immune",      -- Aspect of the Turtle
  [19574]  = "ImmuneSpell",   -- Bestial Wrath (only if The Beast Within (212704) it's active) (immune to some CC's)
  [190927] = "Root",        -- Harpoon
  [212331] = "Root",        -- Harpoon
  [212353] = "Root",        -- Harpoon
  [162480] = "Root",        -- Steel Trap
  [200108] = "Root",        -- Ranger's Net
  [212638] = "CC",        -- Tracker's Net (pvp honor talent) -- Also -80% hit chance melee & range physical (CC and Root category)
  [186387] = "Snare",       -- Bursting Shot
  [224729] = "Snare",       -- Bursting Shot
  [266779] = "Other",       -- Coordinated Assault
  [193530] = "Other",       -- Aspect of the Wild
  [186289] = "Other",       -- Aspect of the Eagle
  [288613] = "Other",       -- Trueshot
  [203337] = "CC",        -- Freezing Trap (Diamond Ice - pvp honor talent)
  [202748] = "Immune",      -- Survival Tactics (pvp honor talent) (not immune, 90% damage reduction)
  [248519] = "ImmuneSpell",   -- Interlope (pvp honor talent)
  --[202914] = "Silence",     -- Spider Sting (pvp honor talent) --no silence, this its the previous effect
  [202933] = "Silence",     -- Spider Sting (pvp honor talent) --this its the silence effect
  [5384]   = "Other",       -- Feign Death
  
    ----------------
    -- Hunter Pets
    ----------------
    [24394]  = "CC",        -- Intimidation
    [50433]  = "Snare",       -- Ankle Crack (Crocolisk)
    [54644]  = "Snare",       -- Frost Breath (Chimaera)
    [35346]  = "Snare",       -- Warp Time (Warp Stalker)
    [160067] = "Snare",       -- Web Spray (Spider)
    [160065] = "Snare",       -- Tendon Rip (Silithid)
    [263852] = "Snare",       -- Talon Rend (Bird of Prey)
    [263841] = "Snare",       -- Petrifying Gaze (Basilisk)
    [288962] = "Snare",       -- Blood Bolt (Blood Beast)
    [50245]  = "Snare",       -- Pin (Crab)
    [263446] = "Snare",       -- Acid Spit (Worm)
    [263423] = "Snare",       -- Lock Jaw (Dog)
    [50285]  = "Snare",       -- Dust Cloud (Tallstrider)
    [263840] = "Snare",       -- Furious Bite (Wolf)
    [54216]  = "Other",       -- Master's Call (root and snare immune only)
    [53148]  = "Root",        -- Charge (tenacity ability)
    [26064]  = "Immune",      -- Shell Shield (damage taken reduced 50%) (Turtle)
    [90339]  = "Immune",      -- Harden Carapace (damage taken reduced 50%) (Beetle)
    [160063] = "Immune",      -- Solid Shell (damage taken reduced 50%) (Shale Spider)
    [264022] = "Immune",      -- Niuzao's Fortitude (damage taken reduced 60%) (Oxen)
    [263920] = "Immune",      -- Gruff (damage taken reduced 60%) (Goat)
    [263867] = "Immune",      -- Obsidian Skin (damage taken reduced 50%) (Core Hound)
    [279410] = "Immune",      -- Bulwark (damage taken reduced 50%) (Krolusk)
    [263938] = "Immune",      -- Silverback (damage taken reduced 60%) (Gorilla)
    [263869] = "Immune",      -- Bristle (damage taken reduced 50%) (Boar)
    [263868] = "Immune",      -- Defense Matrix (damage taken reduced 50%) (Mechanical)
    [263926] = "Immune",      -- Thick Fur (damage taken reduced 60%) (Bear)
    [263865] = "Immune",      -- Scale Shield (damage taken reduced 50%) (Scalehide)
    [279400] = "Immune",      -- Ancient Hide (damage taken reduced 60%) (Pterrordax)
    [160058] = "Immune",      -- Thick Hide (damage taken reduced 60%) (Clefthoof)

  ----------------
  -- Mage
  ----------------
  [31661]  = "CC",        -- Dragon's Breath
  [118]    = "CC",        -- Polymorph
  [61305]  = "CC",        -- Polymorph: Black Cat
  [28272]  = "CC",        -- Polymorph: Pig
  [61721]  = "CC",        -- Polymorph: Rabbit
  [61780]  = "CC",        -- Polymorph: Turkey
  [28271]  = "CC",        -- Polymorph: Turtle
  [161353] = "CC",        -- Polymorph: Polar bear cub
  [126819] = "CC",        -- Polymorph: Porcupine
  [161354] = "CC",        -- Polymorph: Monkey
  [61025]  = "CC",        -- Polymorph: Serpent
  [161355] = "CC",        -- Polymorph: Penguin
  [277787] = "CC",        -- Polymorph: Direhorn
  [277792] = "CC",        -- Polymorph: Bumblebee
  [161372] = "CC",        -- Polymorph: Peacock
  [82691]  = "CC",        -- Ring of Frost
  [140376] = "CC",        -- Ring of Frost
  [122]    = "Root",        -- Frost Nova
  [120]    = "Snare",       -- Cone of Cold
  [116]    = "Snare",       -- Frostbolt
  [44614]  = "Snare",       -- Flurry
  [31589]  = "Snare",       -- Slow
  [205708] = "Snare",       -- Chilled
  [212792] = "Snare",       -- Cone of Cold
  [205021] = "Snare",       -- Ray of Frost
  [59638]  = "Snare",       -- Frostbolt (Mirror Images)
  [228354] = "Snare",       -- Flurry
  [157981] = "Snare",       -- Blast Wave
  [236299] = "Snare",       -- Chrono Shift
  [45438]  = "Immune",      -- Ice Block
  [198065] = "ImmuneSpell",   -- Prismatic Cloak (pvp talent) (not immune, 50% magic damage reduction)
  [198121] = "Root",        -- Frostbite (pvp talent)
  [220107] = "Root",        -- Frostbite
  [157997] = "Root",        -- Ice Nova
  [228600] = "Root",        -- Glacial Spike
  [110909] = "Other",       -- Alter Time
  [110909] = "Other",       -- Alter Time
  [110959] = "Other",       -- Greater Invisibility
  [110960] = "Other",       -- Greater Invisibility
  [198144] = "Other",       -- Ice form (stun/knockback immune)
  [12042]  = "Other",       -- Arcane Power
  [190319] = "Other",       -- Combustion
  [12472]  = "Other",       -- Icy Veins
  [198111] = "Immune",      -- Temporal Shield (not immune, heals all damage taken after 4 sec)

    ----------------
    -- Mage Water Elemental
    ----------------
    [33395]  = "Root",        -- Freeze

  ----------------
  -- Monk
  ----------------
  [119381] = "CC",        -- Leg Sweep
  [115078] = "CC",        -- Paralysis
  [324382] = "Root",        -- Clash
  [116706] = "Root",        -- Disable
  [116095] = "Snare",       -- Disable
  [123586] = "Snare",       -- Flying Serpent Kick
  [196733] = "Snare",       -- Special Delivery
  [205320] = "Snare",       -- Strike of the Windlord (artifact trait)
  [125174] = "Immune",      -- Touch of Karma
  [122783] = "ImmuneSpell",   -- Diffuse Magic (not immune, 60% magic damage reduction)
  [198909] = "CC",        -- Song of Chi-Ji
  [233759] = "Disarm",      -- Grapple Weapon
  [202274] = "CC",        -- Incendiary Brew (honor talent)
  [202346] = "CC",        -- Double Barrel (honor talent)
  [123407] = "Root",        -- Spinning Fire Blossom (honor talent)
  [115176] = "Immune",      -- Zen Meditation (60% damage reduction)
  [202248] = "ImmuneSpell",   -- Guided Meditation (pvp honor talent) (redirect spells to monk)
  [122278] = "Other",       -- Dampen Harm
  [243435] = "Other",       -- Fortifying Brew
  [120954] = "Other",       -- Fortifying Brew
  [201318] = "Other",       -- Fortifying Brew (pvp honor talent)
  [116849] = "Other",       -- Life Cocoon
  [214326] = "Other",       -- Exploding Keg (artifact trait - blind)
  [213664] = "Other",       -- Nimble Brew
  [209584] = "Other",       -- Zen Focus Tea
  [137639] = "Other",       -- Storm, Earth, and Fire
  [152173] = "Other",       -- Serenity
  [115080] = "Other",       -- Touch of Death

  ----------------
  -- Paladin
  ----------------
  [105421] = "CC",        -- Blinding Light
  [853]    = "CC",        -- Hammer of Justice
  [20066]  = "CC",        -- Repentance
  [31935]  = "Silence",     -- Avenger's Shield
  [187219] = "Silence",     -- Avenger's Shield (pvp talent)
  [199512] = "Silence",     -- Avenger's Shield (unknow use)
  [217824] = "Silence",     -- Shield of Virtue (pvp honor talent)
  [204242] = "Snare",       -- Consecration (talent Consecrated Ground)
  [183218] = "Snare",       -- Hand of Hindrance
  [642]    = "Immune",      -- Divine Shield
  [31821]  = "Other",       -- Aura Mastery
  [210256] = "Other",       -- Blessing of Sanctuary
  [210294] = "Other",       -- Divine Favor
  [105809] = "Other",       -- Holy Avenger
  [1044]   = "Other",       -- Blessing of Freedom
  [1022]   = "ImmunePhysical",  -- Hand of Protection
  [204018] = "ImmuneSpell",   -- Blessing of Spellwarding
  [31850]  = "Other",       -- Ardent Defender
  [31884]  = "Other",       -- Avenging Wrath
  [216331] = "Other",       -- Avenging Crusader
  [86659]  = "Immune",      -- Guardian of Ancient Kings (not immune, 50% damage reduction)
  [212641] = "Immune",      -- Guardian of Ancient Kings (not immune, 50% damage reduction)
  [174535] = "Immune",      -- Guardian of Ancient Kings (not immune, 50% damage reduction)
  [10326]  = "CC",        -- Turn Evil
  [228050] = "Immune",      -- Divine Shield (Guardian of the Forgotten Queen)
  [205273] = "Snare",       -- Wake of Ashes (artifact trait) (snare)
  [205290] = "CC",        -- Wake of Ashes (artifact trait) (stun)
  [255937] = "Snare",       -- Wake of Ashes (talent) (snare)
  [255941] = "CC",        -- Wake of Ashes (talent) (stun)
  [199448] = "Immune",      -- Blessing of Sacrifice (Ultimate Sacrifice pvp talent) (not immune, 100% damage transfered to paladin)
  [337851] = "Immune",      -- Guardian of Ancient Kings (Reign of Endless Kings Legendary) (not immune, 50% damage reduction)

  ----------------
  -- Priest
  ----------------
  [605]    = "CC",        -- Dominate Mind
  [64044]  = "CC",        -- Psychic Horror
  [8122]   = "CC",        -- Psychic Scream
  [9484]   = "CC",        -- Shackle Undead
  [87204]  = "CC",        -- Sin and Punishment
  [15487]  = "Silence",     -- Silence
  [64058]  = "Disarm",      -- Psychic Horror
  [114404] = "Root",        -- Void Tendril's Grasp
  [15407]  = "Snare",       -- Mind Flay
  [47585]  = "Immune",      -- Dispersion (not immune, damage taken reduced by 75%)
  [47788]  = "Other",       -- Guardian Spirit (prevent the target from dying)
  [200183] = "Other",       -- Apotheosis
  [197268] = "Other",       -- Ray of Hope
  [33206]  = "Other",       -- Pain Suppression
  [27827]  = "Immune",      -- Spirit of Redemption
  [290114] = "Immune",      -- Spirit of Redemption (pvp honor talent)
  [215769] = "Immune",      -- Spirit of Redemption (pvp honor talent)
  [213602] = "Immune",      -- Greater Fade (pvp honor talent - protects vs spells. melee, ranged attacks + 50% speed)
  [232707] = "Immune",      -- Ray of Hope (pvp honor talent - not immune, only delay damage and heal)
  [213610] = "Other",       -- Holy Ward (pvp honor talent - wards against the next loss of control effect)
  [289655] = "Other",       -- Holy Word: Concentration
  [226943] = "CC",        -- Mind Bomb
  [200196] = "CC",        -- Holy Word: Chastise
  [200200] = "CC",        -- Holy Word: Chastise (talent)
  [204263] = "Snare",       -- Shining Force
  [199845] = "Snare",       -- Psyflay (pvp honor talent - Psyfiend)
  [210979] = "Snare",       -- Focus in the Light (artifact trait)

  ----------------
  -- Rogue
  ----------------
  [2094]   = "CC",        -- Blind
  [1833]   = "CC",        -- Cheap Shot
  [1776]   = "CC",        -- Gouge
  [408]    = "CC",        -- Kidney Shot
  [6770]   = "CC",        -- Sap
  [196958] = "CC",        -- Strike from the Shadows (stun effect)
  [1330]   = "Silence",     -- Garrote - Silence
  [280322] = "Silence",     -- Garrote - Silence
  [3409]   = "Snare",       -- Crippling Poison
  [26679]  = "Snare",       -- Deadly Throw
  [222775] = "Snare",       -- Strike from the Shadows (daze effect)
  [152150] = "Immune",      -- Death from Above (in the air you are immune to CC)
  [31224]  = "ImmuneSpell",   -- Cloak of Shadows
  [51690]  = "Other",       -- Killing Spree
  [13750]  = "Other",       -- Adrenaline Rush
  [199754] = "ImmunePhysical",  -- Riposte (parry chance increased by 100%)
  [1966]   = "Other",       -- Feint
  [121471] = "Other",       -- Shadow Blades
  [45182]  = "Immune",      -- Cheating Death (-85% damage taken)
  [5277]   = "ImmunePhysical",  -- Evasion (dodge chance increased by 100%)
  [199027] = "ImmunePhysical",  -- Veil of Midnight (pvp honor talent)
  [212183] = "Other",       -- Smoke Bomb
  [207777] = "Disarm",      -- Dismantle
  [212283] = "Other",       -- Symbols of Death
  [207736] = "Other",       -- Shadowy Duel
  [212150] = "CC",        -- Cheap Tricks (pvp honor talent) (-75%  melee & range physical hit chance)
  [199743] = "CC",        -- Parley
  [198222] = "Snare",       -- System Shock (pvp honor talent) (90% slow)
  [226364] = "ImmunePhysical",  -- Evasion (Shadow Swiftness, artifact trait)
  [209786] = "Snare",       -- Goremaw's Bite (artifact trait)
  

  ----------------
  -- Shaman
  ----------------
  [77505]  = "CC",        -- Earthquake
  [51514]  = "CC",        -- Hex
  [210873] = "CC",        -- Hex (compy)
  [211010] = "CC",        -- Hex (snake)
  [211015] = "CC",        -- Hex (cockroach)
  [211004] = "CC",        -- Hex (spider)
  [196942] = "CC",        -- Hex (Voodoo Totem)
  [269352] = "CC",        -- Hex (skeletal hatchling)
  [277778] = "CC",        -- Hex (zandalari Tendonripper)
  [277784] = "CC",        -- Hex (wicker mongrel)
  [309328] = "CC",        -- Hex (living honey)
  [118905] = "CC",        -- Static Charge (Capacitor Totem)
  [64695]  = "Root",        -- Earthgrab (Earthgrab Totem)
  [3600]   = "Snare",       -- Earthbind (Earthbind Totem)
  [116947] = "Snare",       -- Earthbind (Earthgrab Totem)
  [196840] = "Snare",       -- Frost Shock
  [51490]  = "Snare",       -- Thunderstorm
  [147732] = "Snare",       -- Frostbrand Attack
  [207498] = "Other",       -- Ancestral Protection (prevent the target from dying)
  [290641] = "Other",       -- Ancestral Gift (PvP Talent) (immune to Silence and Interrupt effects)
  [108271] = "Other",       -- Astral Shift
  [114050] = "Other",       -- Ascendance (Elemental)
  [114051] = "Other",       -- Ascendance (Enhancement)
  [114052] = "Other",       -- Ascendance (Restoration)
  [204361] = "Other",       -- Bloodlust (Shamanism pvp talent)
  [204362] = "Other",       -- Heroism (Shamanism pvp talent)
  [8178]   = "ImmuneSpell",   -- Grounding Totem Effect (Grounding Totem)
  [204399] = "CC",        -- Earthfury (PvP Talent)
  [192058] = "CC",        -- Lightning Surge totem (capacitor totem)
  [210918] = "ImmunePhysical",  -- Ethereal Form
  [305485] = "CC",        -- Lightning Lasso
  [204437] = "CC",        -- Lightning Lasso
  [197214] = "CC",        -- Sundering
  [207654] = "Immune",      -- Servant of the Queen (not immune, 80% damage reduction - artifact trait)
  
    ----------------
    -- Shaman Pets
    ----------------
    [118345] = "CC",        -- Pulverize (Shaman Primal Earth Elemental)

  ----------------
  -- Warlock
  ----------------
  [710]    = "CC",        -- Banish
  [5782]   = "CC",        -- Fear
  [118699] = "CC",        -- Fear
  [130616] = "CC",        -- Fear (Glyph of Fear)
  [5484]   = "CC",        -- Howl of Terror
  [22703]  = "CC",        -- Infernal Awakening
  [6789]   = "CC",        -- Mortal Coil
  [30283]  = "CC",        -- Shadowfury
  [43523]  = "Silence",     -- Unstable Affliction
  [65813]  = "Silence",     -- Unstable Affliction
  [196364] = "Silence",     -- Unstable Affliction
  [285155] = "Silence",     -- Unstable Affliction
  [104773] = "Other",       -- Unending Resolve
  [113860] = "Other",       -- Dark Soul: Misery
  [113858] = "Other",       -- Dark Soul: Instability
  [212295] = "ImmuneSpell",   -- Netherward (reflects spells)
  [233582] = "Root",        -- Entrenched in Flame (pvp honor talent)
  [337113] = "Snare",       -- Sacrolash's Dark Strike (Legendary)

    ----------------
    -- Warlock Pets
    ----------------
    [32752]  = "CC",      -- Summoning Disorientation
    [89766]  = "CC",      -- Axe Toss (Felguard/Wrathguard)
    [115268] = "CC",      -- Mesmerize (Shivarra)
    [6358]   = "CC",      -- Seduction (Succubus)
    [171017] = "CC",      -- Meteor Strike (infernal)
    [171018] = "CC",      -- Meteor Strike (abisal)
    [213688] = "CC",      -- Fel Cleave (Fel Lord - PvP Talent)
    [170996] = "Snare",     -- Debilitate (Terrorguard)
    [170995] = "Snare",     -- Cripple (Doomguard)
    [6360]   = "Snare",     -- Whiplash (Succubus)

  ----------------
  -- Warrior
  ----------------
  [5246]   = "CC",        -- Intimidating Shout (aoe)
  [132168] = "CC",        -- Shockwave
  [107570] = "CC",        -- Storm Bolt
  [132169] = "CC",        -- Storm Bolt
  [46968]  = "CC",        -- Shockwave
  [213427] = "CC",        -- Charge Stun Talent (Warbringer)
  [237744] = "CC",        -- Charge Stun Talent (Warbringer)
  [105771] = "Root",        -- Charge (root)
  [236027] = "Snare",       -- Charge (snare)
  [1715]   = "Snare",       -- Hamstring
  [12323]  = "Snare",       -- Piercing Howl
  [46924]  = "Immune",      -- Bladestorm (not immune to dmg, only to LoC)
  [227847] = "Immune",      -- Bladestorm (not immune to dmg, only to LoC)
  [199038] = "Immune",      -- Leave No Man Behind (not immune, 90% damage reduction)
  [218826] = "Immune",      -- Trial by Combat (warr fury artifact hidden trait) (only immune to death)
  [23920]  = "ImmuneSpell",   -- Spell Reflection
  [169339] = "ImmuneSpell",   -- Spell Reflection
  [329267] = "ImmuneSpell",   -- Spell Reflection
  [335255] = "ImmuneSpell",   -- Spell Reflection
  [330279] = "ImmuneSpell",     -- Overwatch (pvp honor talent)
  [871]    = "Other",       -- Shield Wall
  [12975]  = "Other",       -- Last Stand
  [18499]  = "Other",       -- Berserker Rage
  [107574] = "Other",       -- Avatar
  [262228] = "Other",       -- Deadly Calm
  [198819] = "Other",       -- Sharpen Blade (70% heal reduction)
  [236321] = "Other",       -- War Banner
  [236438] = "Other",       -- War Banner
  [236439] = "Other",       -- War Banner
  [236273] = "Other",       -- Duel
  [198817] = "Other",       -- Sharpen Blade (pvp honor talent)
  [198819] = "Other",       -- Mortal Strike (Sharpen Blade pvp honor talent))
  [184364] = "Other",       -- Enraged Regeneration
  [118038] = "ImmunePhysical",  -- Die by the Sword (parry chance increased by 100%, damage taken reduced by 30%)
  [198760] = "ImmunePhysical",  -- Intercept (pvp honor talent) (intercept the next ranged or melee hit)
  [199085] = "CC",        -- Warpath
  [199042] = "Root",        -- Thunderstruck
  [236236] = "Disarm",      -- Disarm (pvp honor talent - protection)
  [236077] = "Disarm",      -- Disarm (pvp honor talent)
  
  ----------------
  -- Shadowlands Covenant Spells
  ----------------
  [331866] = "CC",        -- Agent of Chaos
  [314416] = "CC",        -- Blind Faith
  [323557] = "CC",        -- Ravenous Frenzy
  [335432] = "CC",        -- Thirst For Anima
  [317589] = "Silence",     -- Tormenting Backlash
  [326062] = "CC",        -- Ancient Aftershock
  [325886] = "CC",        -- Ancient Aftershock
  [296035] = "CC",        -- Invoke Armaments
  [296034] = "CC",        -- Archon of Justice
  [324263] = "CC",        -- Sulfuric Emission
  [347684] = "CC",        -- Sulfuric Emission
  [332423] = "CC",        -- Sparkling Driftglobe Core
  [323996] = "Root",        -- The Hunt
  [325321] = "CC",        -- Wild Hunt's Charge
  [320224] = "CC",        -- Podtender
  [323524] = "Other",       -- Ultimate Form (immune to CC)
  [330752] = "Other",       -- Ascendant Phial (immune to curse, disease, poison, and bleed effects)
  [327140] = "Other",       -- Forgeborne Reveries
  [348303] = "Other",       -- Forgeborne Reveries
  [296040] = "Snare",       -- Vanquishing Sweep
  [320267] = "Snare",       -- Soothing Voice
  [321759] = "Snare",       -- Bearer's Pursuit
  [339051] = "Snare",       -- Demonic Parole
  [336887] = "Snare",       -- Lingering Numbness
  
  ----------------
  -- Other
  ----------------
  [56]     = "CC",        -- Stun (low lvl weapons proc)
  [835]    = "CC",        -- Tidal Charm (trinket)
  [15534]  = "CC",        -- Polymorph (trinket)
  [15535]  = "CC",        -- Enveloping Winds (Six Demon Bag trinket)
  [23103]  = "CC",        -- Enveloping Winds (Six Demon Bag trinket)
  [30217]  = "CC",        -- Adamantite Grenade
  [67769]  = "CC",        -- Cobalt Frag Bomb
  [67890]  = "CC",        -- Cobalt Frag Bomb (belt)
  [30216]  = "CC",        -- Fel Iron Bomb
  [224074] = "CC",        -- Devilsaur's Bite (trinket)
  [127723] = "Root",        -- Covered In Watermelon (trinket)
  [42803]  = "Snare",       -- Frostbolt (trinket)
  [195342] = "Snare",       -- Shrink Ray (trinket)
  [20549]  = "CC",        -- War Stomp (tauren racial)
  [107079] = "CC",        -- Quaking Palm (pandaren racial)
  [255723] = "CC",        -- Bull Rush (highmountain tauren racial)
  [287712] = "CC",        -- Haymaker (kul tiran racial)
  [256948] = "Other",       -- Spatial Rift (void elf racial)
  [302731] = "Other",       -- Ripple in Space (azerite essence)
  [214459] = "Silence",     -- Choking Flames (trinket)
  [19821]  = "Silence",     -- Arcane Bomb
  [131510] = "Immune",      -- Uncontrolled Banish
  [8346]   = "Root",        -- Mobility Malfunction (trinket)
  [39965]  = "Root",        -- Frost Grenade
  [55536]  = "Root",        -- Frostweave Net
  [13099]  = "Root",        -- Net-o-Matic (trinket)
  [13119]  = "Root",        -- Net-o-Matic (trinket)
  [16566]  = "Root",        -- Net-o-Matic (trinket)
  [13138]  = "Root",        -- Net-o-Matic (trinket)
  [148526] = "Root",        -- Sticky Silk
  [15752]  = "Disarm",      -- Linken's Boomerang (trinket)
  [15753]  = "CC",        -- Linken's Boomerang (trinket)
  [1604]   = "Snare",       -- Dazed
  [295048] = "Immune",      -- Touch of the Everlasting (not immune, damage taken reduced 85%)
  [221792] = "CC",        -- Kidney Shot (Vanessa VanCleef (Rogue Bodyguard))
  [222897] = "CC",        -- Storm Bolt (Dvalen Ironrune (Warrior Bodyguard))
  [222317] = "CC",        -- Mark of Thassarian (Thassarian (Death Knight Bodyguard))
  [212435] = "CC",        -- Shado Strike (Thassarian (Monk Bodyguard))
  [212246] = "CC",        -- Brittle Statue (The Monkey King (Monk Bodyguard))
  [238511] = "CC",        -- March of the Withered
  [252717] = "CC",        -- Light's Radiance (Argus powerup)
  [148535] = "CC",        -- Ordon Death Chime (trinket)
  [30504]  = "CC",        -- Poultryized! (trinket)
  [30501]  = "CC",        -- Poultryized! (trinket)
  [30506]  = "CC",        -- Poultryized! (trinket)
  [46567]  = "CC",        -- Rocket Launch (trinket)
  [24753]  = "CC",        -- Trick
  [21847]  = "CC",        -- Snowman
  [21848]  = "CC",        -- Snowman
  [21980]  = "CC",        -- Snowman
  [27880]  = "CC",        -- Stun
  [141928] = "CC",        -- Growing Pains (Whole-Body Shrinka' toy)
  [285643] = "CC",        -- Battle Screech
  [245855] = "CC",        -- Belly Smash
  [262177] = "CC",        -- Into the Storm
  [255978] = "CC",        -- Pallid Glare
  [256050] = "CC",        -- Disoriented (Electroshock Mount Motivator)
  [258258] = "CC",        -- Quillbomb
  [260149] = "CC",        -- Quillbomb
  [258236] = "CC",        -- Sleeping Quill Dart
  [269186] = "CC",        -- Holographic Horror Projector
  [255228] = "CC",        -- Polymorphed (Organic Discombobulation Grenade and some NPCs)
  [334307] = "CC",        -- Imperfect Polymorph (Darktower Parchments: Instant Polymorphist)
  [330607] = "CC",        -- 50UL-TR4P!
  [272188] = "CC",        -- Hammer Smash (quest)
  [264860] = "CC",        -- Binding Talisman
  [238322] = "CC",        -- Arcane Prison
  [171369] = "CC",        -- Arcane Prison
  [172692] = "CC",        -- Unbound Charge
  [295395] = "Silence",     -- Oblivion Spear
  [268966] = "Root",        -- Hooked Deep Sea Net
  [268965] = "Snare",       -- Tidespray Linen Net
  [295366] = "CC",        -- Purifying Blast (Azerite Essences)
  [293031] = "Snare",       -- Suppressing Pulse (Azerite Essences)
  [300009] = "Snare",       -- Suppressing Pulse (Azerite Essences)
  [300010] = "Snare",       -- Suppressing Pulse (Azerite Essences)
  [299109] = "CC",        -- Scrap Grenade
  [302880] = "Silence",     -- Sharkbit (G99.99 Landshark)
  [299577] = "CC",        -- Scroll of Bursting Power
  [296273] = "CC",        -- Mirror Charm
  [304705] = "CC",        -- Razorshell
  [304706] = "CC",        -- Razorshell
  [299802] = "CC",        -- Eel Trap
  [299803] = "CC",        -- Eel Trap
  [299768] = "CC",        -- Shiv and Shank
  [299769] = "CC",        -- Undercut
  [299772] = "CC",        -- Tsunami Slam
  [299805] = "Root",        -- Undertow
  [299785] = "CC",        -- Maelstrom
  [310126] = "Immune",      -- Psychic Shell (not immune, 99% damage reduction) (Lingering Psychic Shell trinket)
  [314585] = "Immune",      -- Psychic Shell (not immune, 50-80% damage reduction) (Lingering Psychic Shell trinket)
  [313448] = "CC",        -- Realized Truth (Corrupted Ring - Face the Truth ring)
  [290105] = "CC",        -- Psychic Scream
  [295953] = "CC",        -- Gnaw
  [292306] = "CC",        -- Leg Sweep
  [247587] = "CC",        -- Holy Word: Chastise
  [291391] = "CC",        -- Sap
  [292224] = "CC",        -- Chaos Nova
  [295459] = "CC",        -- Mortal Coil
  [295240] = "CC",        -- Dragon's Breath
  [284379] = "CC",        -- Intimidation
  [290438] = "CC",        -- Hex
  [283618] = "CC",        -- Hammer of Justice
  [339738] = "CC",        -- Dreamer's Mending (Dreamer's Mending trinket)
  [329491] = "CC",        -- Slumberwood Band (Slumberwood Band ring)
  [344713] = "CC",        -- Pestilent Hex
  [336517] = "CC",        -- Hex
  [292055] = "Immune",      -- Spirit of Redemption
  [290049] = "Immune",      -- Ice Block
  [283627] = "Immune",      -- Divine Shield
  [292230] = "ImmunePhysical",  -- Evasion
  [290494] = "Silence",     -- Avenger's Shield
  [284879] = "Root",        -- Frost Nova
  [284844] = "Root",        -- Glacial Spike
  [339309] = "Root",        -- Everchill Brambles (Everchill Brambles trinket)
  [299256] = "Other",       -- Blessing of Freedom
  [292266] = "Other",       -- Avenging Wrath
  [292222] = "Other",       -- Blur
  [292152] = "Other",       -- Icebound Fortitude
  [292158] = "Other",       -- Astral Shift
  [283433] = "Other",       -- Avatar
  [342890] = "Other",       -- Unhindered Passing (Potion of Unhindered Passing)
  [345548] = "Snare",       -- Spare Meat Hook (Spare Meat Hook trinket)
  [343399] = "Snare",       -- Heart of a Gargoyle (Pulsating Stoneheart trinket)
  [292297] = "Snare",       -- Cone of Cold
  [283649] = "Snare",       -- Crippling Poison
  [284860] = "Snare",       -- Flurry
  [284217] = "Snare",       -- Concussive Shot
  [290292] = "Snare",       -- Vengeful Retreat
  [292156] = "Snare",       -- Typhoon
  [295282] = "Snare",       -- Concussive Shot
  [283558] = "Snare",       -- Chains of Ice
  [284414] = "Snare",       -- Mind Flay
  [290441] = "Snare",       -- Frost Shock
  [295577] = "Snare",       -- Frostbrand
  [45954]  = "Immune",      -- Ahune's Shield (damage taken reduced 90%)
  [133362] = "CC",        -- Megafantastic Discombobumorphanator
  [286167] = "CC",        -- Cold Crash
  [229413] = "CC",        -- Stormburst
  [142769] = "CC",        -- Stasis Beam
  [133308] = "Root",        -- Throw Net
  [291399] = "CC",        -- Blinding Peck
  [176813] = "Snare",       -- Itchy Spores
  [298356] = "CC",        -- Tidal Blast
  [121548] = "Immune",      -- Ice Block
  [129032] = "Snare",       -- Frostbolt  
  [121547] = "CC",        -- Polymorph: Sheep
  [278575] = "CC",        -- Steel-Toed Boots
  [58729]  = "Immune",      -- Spiritual Immunity
  [95332]  = "Immune",      -- Spiritual Immunity
  [171496] = "Immune",      -- Hallowed Ground
  [178266] = "Immune",      -- Hallowed Ground
  [222206] = "CC",        -- Playing with Matches
  [298272] = "CC",        -- Massive Stone
  [293935] = "CC",        -- Overcharged!
  [281923] = "CC",        -- Super Heroic Landing
  [52696]  = "CC",        -- Constricting Chains
  [176278] = "CC",        -- Deep Freeze
  [176169] = "Root",        -- Freezing Field
  [176276] = "Root",        -- Frost Nova
  [176268] = "Snare",       -- Frostbolt
  [176273] = "Snare",       -- Frostbolt Volley
  [176269] = "Immune",      -- Ice Block
  [176204] = "CC",        -- Mass Polymorph
  [176608] = "CC",        -- Combustion Nova
  [176098] = "Snare",       -- Phoenix Flames
  [174955] = "CC",        -- Frozen
  [33844]  = "Root",        -- Entangling Roots
  [178072] = "CC",        -- Howl of Terror
  [32323]  = "CC",        -- Charge
  [164464] = "CC",        -- Intimidating Shout
  [164465] = "CC",        -- Intimidating Shout
  [164092] = "CC",        -- Shockwave
  [164444] = "Immune",      -- Dispersion
  [164443] = "CC",        -- Psychic Scream
  [178064] = "CC",        -- Hex
  [79899]  = "Snare",       -- Chains of Ice
  [79850]  = "Root",        -- Frost Nova
  [79858]  = "Snare",       -- Frostbolt
  [177606] = "Root",        -- Entangling Roots
  [164067] = "Root",        -- Frost Nova
  [162608] = "Snare",       -- Frostbolt
  [164392] = "CC",        -- Leg Sweep
  [178058] = "CC",        -- Blind
  [178055] = "ImmuneSpell",   -- Cloak of Shadows
  [168382] = "CC",        -- Psychic Scream
  [162764] = "CC",        -- Hammer of Justice
  [35963]  = "Root",        -- Improved Wing Clip
  [189287] = "Snare",       -- Grind
  [79857]  = "Snare",       -- Blast Wave
  [162638] = "Silence",     -- Avenger's Shield
  [189265] = "Snare",       -- Shred
  [139777] = "CC",        -- Stone Smash
  [304349] = "Silence",     -- Pacifying Screech
  [292693] = "Immune",      -- Nullification Field
  [300524] = "CC",        -- Song of Azshara
  [91933]  = "CC",        -- Intimidating Roar
  [228318] = "Other",       -- Enrage
  [276846] = "CC",        -- Silvered Weapons
  [287478] = "CC",        -- Oppressive Power
  [287371] = "CC",        -- Spirits of Madness
  [8312]   = "Root",        -- Trap (Hunting Net trinket)
  [17308]  = "CC",        -- Stun (Hurd Smasher fist weapon)
  [23454]  = "CC",        -- Stun (The Unstoppable Force weapon)
  [9179]   = "CC",        -- Stun (Tigule and Foror's Strawberry Ice Cream item)
  [13327]  = "CC",        -- Reckless Charge (Goblin Rocket Helmet)
  [13181]  = "CC",        -- Gnomish Mind Control Cap (Gnomish Mind Control Cap helmet)
  [26740]  = "CC",        -- Gnomish Mind Control Cap (Gnomish Mind Control Cap helmet)
  [8345]   = "CC",        -- Control Machine (Gnomish Universal Remote trinket)
  [13235]  = "CC",        -- Forcefield Collapse (Gnomish Harm Prevention belt)
  [13158]  = "CC",        -- Rocket Boots Malfunction (Engineering Rocket Boots)
  [13466]  = "CC",        -- Goblin Dragon Gun (engineering trinket malfunction)
  [8224]   = "CC",        -- Cowardice (Savory Deviate Delight effect)
  [8225]   = "CC",        -- Run Away! (Savory Deviate Delight effect)
  [23131]  = "ImmuneSpell",   -- Frost Reflector (Gyrofreeze Ice Reflector trinket) (only reflect frost spells)
  [23097]  = "ImmuneSpell",   -- Fire Reflector (Hyper-Radiant Flame Reflector trinket) (only reflect fire spells)
  [23132]  = "ImmuneSpell",   -- Shadow Reflector (Ultra-Flash Shadow Reflector trinket) (only reflect shadow spells)
  [30003]  = "ImmuneSpell",   -- Sheen of Zanza
  [35474]  = "CC",        -- Drums of Panic
  [23444]  = "CC",        -- Transporter Malfunction
  [23447]  = "CC",        -- Transporter Malfunction
  [23456]  = "CC",        -- Transporter Malfunction
  [23457]  = "CC",        -- Transporter Malfunction
  [8510]   = "CC",        -- Large Seaforium Backfire
  [7144]   = "ImmunePhysical",  -- Stone Slumber
  [12843]  = "Immune",      -- Mordresh's Shield
  [25282]  = "Immune",      -- Shield of Rajaxx
  [27619]  = "Immune",      -- Ice Block
  [21892]  = "Immune",      -- Arcane Protection
  [13237]  = "CC",        -- Goblin Mortar
  [5134]   = "CC",        -- Flash Bomb
  [4064]   = "CC",        -- Rough Copper Bomb
  [4065]   = "CC",        -- Large Copper Bomb
  [4066]   = "CC",        -- Small Bronze Bomb
  [4067]   = "CC",        -- Big Bronze Bomb
  [4068]   = "CC",        -- Iron Grenade
  [4069]   = "CC",        -- Big Iron Bomb
  [12543]  = "CC",        -- Hi-Explosive Bomb
  [12562]  = "CC",        -- The Big One
  [12421]  = "CC",        -- Mithril Frag Bomb
  [19784]  = "CC",        -- Dark Iron Bomb
  [19769]  = "CC",        -- Thorium Grenade
  [13808]  = "CC",        -- M73 Frag Grenade
  [21188]  = "CC",        -- Stun Bomb Attack
  [9159]   = "CC",        -- Sleep (Green Whelp Armor chest)
  --[9774]   = "Other",       -- Immune Root (spider belt)
  [18278]  = "Silence",     -- Silence (Silent Fang sword)
  [16470]  = "CC",        -- Gift of Stone
  [700]    = "CC",        -- Sleep (Slumber Sand item)
  [1090]   = "CC",        -- Sleep
  [12098]  = "CC",        -- Sleep
  [20663]  = "CC",        -- Sleep
  [20669]  = "CC",        -- Sleep
  [20989]  = "CC",        -- Sleep
  [24004]  = "CC",        -- Sleep
  [8064]   = "CC",        -- Sleepy
  [17446]  = "CC",        -- The Black Sleep
  [29124]  = "CC",        -- Polymorph
  [14621]  = "CC",        -- Polymorph
  [27760]  = "CC",        -- Polymorph
  [28406]  = "CC",        -- Polymorph Backfire
  [851]    = "CC",        -- Polymorph: Sheep
  [16707]  = "CC",        -- Hex
  [16708]  = "CC",        -- Hex
  [16709]  = "CC",        -- Hex
  [18503]  = "CC",        -- Hex
  [20683]  = "CC",        -- Highlord's Justice
  [17286]  = "CC",        -- Crusader's Hammer
  [17820]  = "Other",       -- Veil of Shadow
  [12096]  = "CC",        -- Fear
  [27641]  = "CC",        -- Fear
  [29168]  = "CC",        -- Fear
  [30002]  = "CC",        -- Fear
  [26042]  = "CC",        -- Psychic Scream
  [27610]  = "CC",        -- Psychic Scream
  [9915]   = "Root",        -- Frost Nova
  [14907]  = "Root",        -- Frost Nova
  [22645]  = "Root",        -- Frost Nova
  [15091]  = "Snare",       -- Blast Wave
  [17277]  = "Snare",       -- Blast Wave
  [23039]  = "Snare",       -- Blast Wave
  [23113]  = "Snare",       -- Blast Wave
  [12548]  = "Snare",       -- Frost Shock
  [22582]  = "Snare",       -- Frost Shock
  [23115]  = "Snare",       -- Frost Shock
  [19133]  = "Snare",       -- Frost Shock
  [21030]  = "Snare",       -- Frost Shock
  [11538]  = "Snare",       -- Frostbolt
  [21369]  = "Snare",       -- Frostbolt
  [20297]  = "Snare",       -- Frostbolt
  [20806]  = "Snare",       -- Frostbolt
  [20819]  = "Snare",       -- Frostbolt
  [12737]  = "Snare",       -- Frostbolt
  [20792]  = "Snare",       -- Frostbolt
  [17503]  = "Snare",       -- Frostbolt
  [23412]  = "Snare",       -- Frostbolt
  [24942]  = "Snare",       -- Frostbolt
  [23102]  = "Snare",       -- Frostbolt
  [20828]  = "Snare",       -- Cone of Cold
  [22746]  = "Snare",       -- Cone of Cold
  [20717]  = "Snare",       -- Sand Breath
  [16568]  = "Snare",       -- Mind Flay
  [29407]  = "Snare",       -- Mind Flay
  [16094]  = "Snare",       -- Frost Breath
  [16340]  = "Snare",       -- Frost Breath
  [17174]  = "Snare",       -- Concussive Shot
  [27634]  = "Snare",       -- Concussive Shot
  [20654]  = "Root",        -- Entangling Roots
  [22800]  = "Root",        -- Entangling Roots
  [12520]  = "Root",        -- Teleport from Azshara Tower
  [12521]  = "Root",        -- Teleport from Azshara Tower
  [12024]  = "Root",        -- Net
  [12023]  = "Root",        -- Web
  [13608]  = "Root",        -- Hooked Net
  [10017]  = "Root",        -- Frost Hold
  [23279]  = "Root",        -- Crippling Clip
  [3542]   = "Root",        -- Naraxis Web
  [5567]   = "Root",        -- Miring Mud
  [4932]   = "ImmuneSpell",   -- Ward of Myzrael
  [7383]   = "ImmunePhysical",  -- Water Bubble
  [101]    = "CC",        -- Trip
  [3109]   = "CC",        -- Presence of Death
  [3143]   = "CC",        -- Glacial Roar
  [5403]   = "Root",        -- Crash of Waves
  [3260]   = "CC",        -- Violent Shield Effect
  [3263]   = "CC",        -- Touch of Ravenclaw
  [3271]   = "CC",        -- Fatigued
  [5106]   = "CC",        -- Crystal Flash
  [6266]   = "CC",        -- Kodo Stomp
  [6730]   = "CC",        -- Head Butt
  [6982]   = "CC",        -- Gust of Wind
  [6749]   = "CC",        -- Wide Swipe
  [6754]   = "CC",        -- Slap!
  [6927]   = "CC",        -- Shadowstalker Slash
  [7961]   = "CC",        -- Azrethoc's Stomp
  [8151]   = "CC",        -- Surprise Attack
  [3635]   = "CC",        -- Crystal Gaze
  [8646]   = "CC",        -- Snap Kick
  [27620]  = "Silence",     -- Snap Kick
  [27814]  = "Silence",     -- Kick
  [21990]  = "CC",        -- Tornado
  [19725]  = "CC",        -- Turn Undead
  [19469]  = "CC",        -- Poison Mind
  [10134]  = "CC",        -- Sand Storm
  [12613]  = "CC",        -- Dark Iron Taskmaster Death
  [13488]  = "CC",        -- Firegut Fear Storm
  [17738]  = "CC",        -- Curse of the Plague Rat
  [20019]  = "CC",        -- Engulfing Flames
  [19136]  = "CC",        -- Stormbolt
  [20685]  = "CC",        -- Storm Bolt
  [16803]  = "CC",        -- Flash Freeze
  [14100]  = "CC",        -- Terrifying Roar
  [17276]  = "CC",        -- Scald
  [18812]  = "CC",        -- Knockdown
  [11430]  = "CC",        -- Slam
  [28335]  = "CC",        -- Whirlwind
  [16451]  = "CC",        -- Judge's Gavel
  [23601]  = "CC",        -- Scatter Shot
  [25260]  = "CC",        -- Wings of Despair
  [23275]  = "CC",        -- Dreadful Fright
  [24919]  = "CC",        -- Nauseous
  [21167]  = "CC",        -- Snowball
  [25815]  = "CC",        -- Frightening Shriek
  [290378] = "Immune",      -- Rock of Life
  [9612]   = "CC",        -- Ink Spray (Chance to hit reduced by 50%)
  [4320]   = "Silence",     -- Trelane's Freezing Touch
  [4243]   = "Silence",     -- Pester Effect
  [9552]   = "Silence",     -- Searing Flames
  [10576]  = "Silence",     -- Piercing Howl
  [12943]  = "Silence",     -- Fell Curse Effect
  [23417]  = "Silence",     -- Smother
  [10851]  = "Disarm",      -- Grab Weapon
  [6576]   = "CC",        -- Intimidating Growl
  [7093]   = "CC",        -- Intimidation
  [8715]   = "CC",        -- Terrifying Howl
  [8817]   = "CC",        -- Smoke Bomb
  [3442]   = "CC",        -- Enslave
  [3651]   = "ImmuneSpell",   -- Shield of Reflection
  [20223]  = "ImmuneSpell",   -- Magic Reflection
  [25772]  = "CC",        -- Mental Domination
  [16053]  = "CC",        -- Dominion of Soul (Orb of Draconic Energy)
  [15859]  = "CC",        -- Dominate Mind
  [20740]  = "CC",        -- Dominate Mind
  [21330]  = "CC",        -- Corrupted Fear (Deathmist Raiment set)
  [27868]  = "Root",        -- Freeze (Magister's and Sorcerer's Regalia sets)
  [17333]  = "Root",        -- Spider's Kiss (Spider's Kiss set)
  [26108]  = "CC",        -- Glimpse of Madness (Dark Edge of Insanity axe)
  [9462]   = "Snare",       -- Mirefin Fungus
  [19137]  = "Snare",       -- Slow
  [21847]  = "CC",        -- Snowman
  [21848]  = "CC",        -- Snowman
  [21980]  = "CC",        -- Snowman
  [6724]   = "Immune",      -- Light of Elune
  [24360]  = "CC",        -- Greater Dreamless Sleep Potion
  [15822]  = "CC",        -- Dreamless Sleep Potion
  [15283]  = "CC",        -- Stunning Blow (Dark Iron Pulverizer weapon)
  [21152]  = "CC",        -- Earthshaker (Earthshaker weapon)
  [16600]  = "CC",        -- Might of Shahram (Blackblade of Shahram sword)
  [16597]  = "Snare",       -- Curse of Shahram (Blackblade of Shahram sword)
  [13496]  = "Snare",       -- Dazed (Mug O' Hurt mace)
  [3238]   = "Other",       -- Nimble Reflexes
  [5990]   = "Other",       -- Nimble Reflexes
  [6615]   = "Other",       -- Free Action Potion
  [11359]  = "Other",       -- Restorative Potion
  [24364]  = "Other",       -- Living Free Action
  [23505]  = "Other",       -- Berserking
  [24378]  = "Other",       -- Berserking
  [19135]  = "Other",       -- Avatar
  [26198]  = "CC",        -- Whisperings of C'Thun
  [17624]  = "CC",        -- Flask of Petrification
  [13534]  = "Disarm",      -- Disarm (The Shatterer weapon)
  [13439]  = "Snare",       -- Frostbolt (some weapons)
  [16621]  = "ImmunePhysical",  -- Self Invulnerability (Invulnerable Mail)
  [27559]  = "Silence",     -- Silence (Jagged Obsidian Shield)
  [13907]  = "CC",        -- Smite Demon (Enchant Weapon - Demonslaying)
  [18798]  = "CC",        -- Freeze (Freezing Band)
  
  -- PvE
  --[123456] = "PvE",       -- This is just an example, not a real spell
  ------------------------
  ---- PVE SHADOWLANDS
  ------------------------
  -- Castle Nathria
  -- -- Trash
  [341867] = "CC",        -- Subdue
  [329438] = "CC",        -- Doubt (chance to hit with attacks and abilities decreased by 100%)
  [327474] = "CC",        -- Crushing Doubt
  [326227] = "CC",        -- Insidious Anxieties
  [340622] = "CC",        -- Headbutt
  [339525] = "Root",        -- Concentrate Anima
  -- -- Shriekwing
  [343024] = "CC",        -- Horrified
  -- -- Sun King's Salvation
  [333145] = "CC",        -- Return to Stone
  -- -- Artificer Xy'mox
  [326302] = "CC",        -- Stasis Trap
  [327414] = "CC",        -- Possession
  -- -- Hungering Destroyer
  [329298] = "Other",       -- Gluttonous Miasma (healing received reduced by 100%)
  -- -- Lady Inerva Darkvein
  [332664] = "Root",        -- Concentrated Anima
  [340477] = "Root",        -- Concentrated Anima
  [335396] = "Root",        -- Hidden Desire
  [341746] = "Root",        -- Rooted in Anima
  --[324982] = "Silence",     -- Shared Suffering
  -- -- The Council of Blood
  [346694] = "Immune",      -- Unyielding Shield
  [335775] = "Immune",      -- Unyielding Shield (not immune, damage taken reduced by 90%)
  [327619] = "CC",        -- Waltz of Blood
  [328334] = "CC",        -- Tactical Advance
  [331706] = "CC",        -- Scarlet Letter
  -- -- Sludgefist
  [331314] = "CC",        -- Destructive Impact
  [335295] = "CC",        -- Shattering Chain
  [332572] = "CC",        -- Falling Rubble
  [339067] = "CC",        -- Heedless Charge
  [339181] = "Root",        -- Chain Slam (Root)
  -- -- Stone Legion Generals
  [329636] = "Immune",      -- Hardened Stone Form (not immune, damage taken reduced by 95%)
  [329808] = "Immune",      -- Hardened Stone Form (not immune, damage taken reduced by 95%)
  [342735] = "CC",        -- Ravenous Feast
  [343273] = "CC",        -- Ravenous Feast
  [339693] = "CC",        -- Crystalline Burst
  [334616] = "CC",        -- Petrified
  [331986] = "Root",        -- Chains of Suppression
  -- -- Sire Denathrius
  [326851] = "CC",        -- Blood Price
  [328276] = "CC",        -- March of the Penitent
  [328222] = "CC",        -- March of the Penitent
  [341732] = "Silence",     -- Searing Censure
  [341426] = "Silence",     -- Searing Censure
  -- Shadowlands World Bosses
  -- -- Valinor, The Light of Eons
  [327280] = "CC",        -- Recharge Anima
  -- -- Oranomonos the Everbranching
  [338853] = "Root",        -- Rapid Growth
  [339040] = "Other",       -- Withered Winds (melee and ranged chance to hit reduced by 30%)
  [339023] = "Snare",       -- Dirge of the Fallen Sanctum
  ------------------------
  -- Shadowlands Mythics
  -- -- Common
  [342494] = "CC",        -- Belligerent Boast
  -- -- De Other Side
  [201441] = "Immune",      -- Thorium Plating
  [201581] = "Immune",      -- Mega Miniaturization Turbo-Beam (Chance to be hit by attacks and spells reduced by 95%)
  [202310] = "CC",        -- Hyper Zap-o-matic Ultimate Mark III
  [330434] = "Root",        -- Buzz-Saw
  [331847] = "CC",        -- W-00F
  [339978] = "CC",        -- Pacifying Mists
  [324010] = "CC",        -- Eruption
  [331381] = "CC",        -- Slipped
  [338762] = "CC",        -- Slipped
  [334505] = "CC",        -- Shimmerdust Sleep
  [321349] = "CC",        -- Absorbing Haze
  [340026] = "CC",        -- Wailing Grief
  [320132] = "CC",        -- Shadowfury
  [332605] = "CC",        -- Hex
  [320008] = "Snare",       -- Frostbolt
  [332236] = "Snare",       -- Sludgegrab
  [334530] = "Snare",       -- Snaring Gore
  -- -- Halls of Atonement
  [322977] = "CC",        -- Sinlight Visions
  [339237] = "CC",        -- Sinlight Visions
  [319724] = "Immune",      -- Stone Form
  [323741] = "Immune",      -- Ephemeral Visage
  [319611] = "CC",        -- Turned to Stone
  [326876] = "CC",        -- Shredded Ankles
  [326617] = "CC",        -- Turn to Stone
  [326607] = "Immune",      -- Turn to Stone (not immune, damage taken reduced by 50%)
  -- -- Mists of Tirna Scithe
  [323149] = "Immune",      -- Embrace Darkness (not immune, damage taken reduced by 50%)
  [321005] = "CC",        -- Soul Shackle
  [321010] = "CC",        -- Soul Shackle
  [323059] = "CC",        -- Droman's Wrath
  [323137] = "CC",        -- Bewildering Pollen
  [321968] = "CC",        -- Bewildering Pollen
  [328756] = "CC",        -- Repulsive Visage
  [321893] = "CC",        -- Freezing Burst
  [321828] = "CC",        -- Patty Cake
  [337220] = "CC",        -- Parasitic Pacification
  [337251] = "CC",        -- Parasitic Incapacitation
  [337253] = "CC",        -- Parasitic Domination
  [322487] = "CC",        -- Overgrowth
  [340160] = "CC",        -- Radiant Breath
  [324859] = "Root",        -- Bramblethorn Entanglement
  [325027] = "Snare",       -- Bramble Burst
  [322486] = "Snare",       -- Overgrowth
  -- -- The Necrotic Wake
  [320646] = "CC",        -- Fetid Gas
  [335141] = "ImmunePhysical",  -- Dark Shroud
  [343504] = "CC",        -- Dark Grasp
  [326629] = "Immune",      -- Noxious Fog
  [322548] = "CC",        -- Meat Hook
  [327041] = "CC",        -- Meat Hook
  [320788] = "Root",        -- Frozen Binds
  [323730] = "Root",        -- Frozen Binds
  [322274] = "Snare",       -- Enfeeble
  [334748] = "CC",        -- Drain Fluids
  [345625] = "Silence",     -- Death Burst
  [324293] = "CC",        -- Rasping Scream
  [328051] = "Immune",      -- Discarded Shield (not immune, damage taken reduced by 50%)
  [333489] = "Other",       -- Necrotic Breath (healing received reduced by 50%)
  [320573] = "Other",       -- Shadow Well (healing received reduced by 100%)
  [324381] = "Snare",       -- Chill Scythe
  -- -- Plaguefall
  [321521] = "Immune",      -- Congealed Bile (not immune, damage taken reduced by 75%)
  [326242] = "Root",        -- Slime Wave
  [331818] = "CC",        -- Shadow Ambush
  [336306] = "CC",        -- Web Wrap
  [336301] = "CC",        -- Web Wrap
  [333173] = "CC",        -- Volatile Substance
  [328409] = "Root",        -- Enveloping Webbing
  [328012] = "Root",        -- Binding Fungus
  [328180] = "Root",        -- Gripping Infection
  [328002] = "Snare",       -- Hurl Spores
  [334926] = "Snare",       -- Wretched Phlegm
  -- -- Sanguine Depths
  [324092] = "Immune",      -- Shining Radiance (not immune, damage taken reduced by 65%)
  [327107] = "Immune",      -- Shining Radiance (not immune, damage taken reduced by 75%)
  [326836] = "Silence",     -- Curse of Suppression
  [335306] = "Root",        -- Barbed Shackles
  -- -- Spires of Ascension
  [324205] = "CC",        -- Blinding Flash
  [323878] = "CC",        -- Drained
  [323744] = "CC",        -- Pounce
  [347598] = "CC",        -- Carriage Knockdown
  [330388] = "CC",        -- Terrifying Screech
  [330453] = "Snare",       -- Stone Breath
  [331906] = "Snare",       -- Fling Muck
  -- -- Theater of Pain
  [333540] = "CC",        -- Opportunity Strikes
  [320112] = "CC",        -- Blood and Glory
  [320287] = "CC",        -- Blood and Glory
  [319539] = "CC",        -- Soulless
  [333567] = "CC",        -- Possession
  [333710] = "Root",        -- Grasping Hands
  [342691] = "Root",        -- Grasping Hands
  [319567] = "Root",        -- Grasping Hands
  [333301] = "CC",        -- Curse of Desolation
  [323750] = "CC",        -- Vile Gas
  [330592] = "CC",        -- Vile Eruption
  [330608] = "CC",        -- Vile Eruption
  [323831] = "CC",        -- Death Grasp
  [321768] = "CC",        -- On the Hook
  [319531] = "CC",        -- Draw Soul
  [332708] = "CC",        -- Ground Smash
  [330562] = "CC",        -- Demoralizing Shout (damage done reduced by 50%)
  [320679] = "Snare",       -- Charge
  [342103] = "Snare",       -- Rancid Bile
  [330810] = "Snare",       -- Bind Soul
  ------------------------
  -- Torghast, Tower of the Damned
  [314702] = "CC",        -- Twisted Hellchoker
  [307612] = "CC",        -- Darkening Canopy
  [329454] = "CC",        -- Ogundimu's Fist
  [314691] = "CC",        -- Darkhelm of Nuren
  [333599] = "CC",        -- Pridebreaker's Anvil
  [312902] = "CC",        -- Volatile Augury
  [331917] = "CC",        -- Force Pull
  [332531] = "CC",        -- Ancient Drake Breath
  [332544] = "CC",        -- Imprison
  [314590] = "CC",        -- Big Clapper
  [333762] = "CC",        -- The Hunt
  [330858] = "CC",        -- Creeping Freeze
  [321395] = "CC",        -- Polymorph: Mawrat
  [302583] = "CC",        -- Polymorph
  [321134] = "CC",        -- Polymorph
  [334392] = "CC",        -- Polymorph
  [329398] = "CC",        -- Pandemonium
  [345524] = "CC",        -- Mad Wizard's Confusion
  [333767] = "CC",        -- Distracting Charges
  [342375] = "Silence",     -- Tormenting Backlash
  [342414] = "Silence",     -- Cracked Mindscreecher
  [332547] = "Disarm",      -- Animate Armaments
  [337097] = "Root",        -- Grasping Tendrils
  [331362] = "Root",        -- Hateful Shard-Ring
  [342373] = "Root",        -- Fae Tendrils
  [333561] = "Root",        -- Nightmare Tendrils
  [332205] = "Other",       -- Smoking Shard of Teleportation
  [331188] = "Other",       -- Cadaverous Cleats
  [333920] = "ImmuneSpell",   -- Cloak of Shadows
  [332831] = "ImmuneSpell",   -- Anti-Magic Zone
  [335103] = "Immune",      -- Divine Shield
  [295963] = "Immune",      -- Crumbling Aegis
  [308204] = "Immune",      -- Crumbling Aegis
  [331356] = "Immune",      -- Craven Strategem
  [323220] = "Immune",      -- Shield of Unending Fury
  [331464] = "Immune",      -- Fogged Crystal (not immune, damage taken reduced by 90%)
  [342783] = "ImmunePhysical",  -- Crystallized Dreams
  [322136] = "Snare",       -- Dissolving Vial
  [338065] = "Snare",       -- Stoneflesh Figurine
  [332165] = "CC",        -- Fearsome Shriek
  [329930] = "CC",        -- Terrifying Screech
  [334575] = "CC",        -- Earthen Crush
  [334562] = "CC",        -- Suppress
  [295985] = "CC",        -- Ground Crush
  [330458] = "CC",        -- Shockwave
  [327461] = "CC",        -- Meat Hook
  [294173] = "CC",        -- Hulking Charge
  [297018] = "CC",        -- Fearsome Howl
  [330438] = "CC",        -- Fearsome Howl
  [298844] = "CC",        -- Fearsome Howl
  [320600] = "CC",        -- Fearsome Howl
  [170751] = "CC",        -- Crushing Shadows
  [329608] = "CC",        -- Terrifying Roar
  [242391] = "CC",        -- Terror
  [301952] = "Silence",     -- Silencing Calm
  [329903] = "Silence",     -- Silence
  [329319] = "Disarm",      -- Disarm
  [304949] = "Root",        -- Falling Strike
  [295945] = "Root",        -- Rat Traps
  [304831] = "Root",        -- Chains of Ice
  [296023] = "Root",        -- Lockdown
  [259220] = "Root",        -- Barbed Net
  [296454] = "Immune",      -- Vanish to Nothing
  [167012] = "Immune",      -- Incorporeal (not immune, damage taken reduced by 99%)
  [336556] = "Immune",      -- Concealing Fog (not immune, damage taken reduced by 50%)
  [294517] = "Immune",      -- Phasing Roar (not immune, damage taken reduced by 80%)
  [339006] = "ImmunePhysical",  -- Ephemeral Body (not immune, physical damage taken reduced by 75%)
  [297166] = "ImmunePhysical",  -- Armor Plating (not immune, physical damage taken reduced by 50%)
  [339010] = "ImmuneSpell",   -- Resonating Body (not immune, magic damage taken reduced by 75%)
  [302543] = "ImmuneSpell",   -- Glimmering Barrier (not immune, magic damage taken reduced by 50%)
  [38572]  = "Other",       -- Mortal Cleave (healing effects reduced by 50%)
  [321633] = "Snare",       -- Frost Strike
  [330479] = "Snare",       -- Gunk
  [327471] = "Snare",       -- Noxious Cloud
  [297292] = "Snare",       -- Thorned Shell
  [295991] = "Snare",       -- Lumbering Might
  [295929] = "Snare",       -- Rats!
  [302552] = "Snare",       -- Sedative Dust
  [330646] = "Snare",       -- Cloying Juices
  [304093] = "Snare",       -- Mass Debilitate
  [335685] = "Snare",       -- Wracking Torment
  [292910] = "Snare",       -- Shackles
  [292942] = "Snare",       -- Iron Shackles
  [295001] = "Snare",       -- Whirlwind
  [329905] = "Snare",       -- Mass Slow
  [329862] = "Snare",       -- Ghastly Wail
  [329325] = "Snare",       -- Cripple
  [185493] = "Snare",       -- Cripple
  [329326] = "Snare",       -- Dark Binding
  ------------------------
  ---- PVE BFA
  ------------------------
  -- Ny'alotha, The Waking City Raid
  -- -- Trash
  [313949] = "Immune",      -- Ny'alotha Gateway
  [315071] = "Immune",      -- Ny'alotha Gateway
  [315080] = "Immune",      -- Ny'alotha Gateway
  [315214] = "Immune",      -- Ny'alotha Gateway
  [311052] = "Immune",      -- Steadfast Defense (not immune, 75% damage reduction)
  [311073] = "Immune",      -- Steadfast Defense (not immune, 75% damage reduction)
  [310830] = "CC",        -- Disorienting Strike
  [315013] = "Silence",     -- Bursting Shadows
  [316951] = "CC",        -- Voracious Charge
  [311552] = "CC",        -- Fear the Void
  [311041] = "CC",        -- Drive to Madness
  [318785] = "CC",        -- Corrupted Touch
  [318880] = "Root",        -- Corrupted Touch
  [316143] = "Snare",       -- Thunder Clap
  -- -- Wrathion
  [314347] = "CC",        -- Noxious Choke
  [313175] = "Immune",      -- Hardened Core
  [306995] = "Immune",      -- Smoke and Mirrors
  -- -- Maut
  [307586] = "CC",        -- Devoured Abyss
  [309853] = "Silence",     -- Devoured Abyss
  -- -- The Prophet Skitra
  [313208] = "Immune",      -- Intangible Illusion
  -- -- Dark Inquisitor
  [314035] = "Immune",      -- Void Shield
  [316211] = "CC",        -- Terror Wave
  [305575] = "Snare",       -- Ritual Field
  --[309569] = "CC",        -- Voidwoken (damage dealt reduced 99%)
  --[312406] = "CC",        -- Voidwoken (damage dealt reduced 99%)
  -- -- The Hivemind
  [307202] = "Immune",      -- Shadow Veil (damage taken reduced by 99%)
  [308873] = "CC",        -- Corrosive Venom
  [313460] = "Other",       -- Nullification (healing received reduced by 100%)
  -- -- Shad'har the Insatiable
  [306928] = "CC",        -- Umbral Breath
  [306930] = "Other",       -- Entropic Breath (healing received reduced by 50%)
  -- -- Drest'agath
  [310246] = "CC",        -- Void Grip
  [310361] = "CC",        -- Unleashed Insanity
  [310552] = "Snare",       -- Mind Flay
  -- -- Il'gynoth
  [311367] = "CC",        -- Touch of the Corruptor
  [310322] = "CC",        -- Morass of Corruption
  -- -- Vexiona
  [307645] = "CC",        -- Heart of Darkness
  [315932] = "CC",        -- Brutal Smash
  [307729] = "CC",        -- Fanatical Ascension
  [307075] = "CC",        -- Power of the Chosen
  [316745] = "CC",        -- Power of the Chosen
  [310323] = "Snare",       -- Desolation
  -- -- Ra Den
  [315207] = "CC",        -- Stunned
  [306637] = "Silence",     -- Unstable Void Burst
  [306645] = "Silence",     -- Consuming Void
  [309777] = "Other",       -- Void Defilement (all healing taken reduced 50%)
  -- -- Carapace of N'Zoth
  [307832] = "CC",        -- Servant of N'Zoth
  [312158] = "Immune",      -- Ashjra'kamas, Shroud of Resolve
  [317165] = "CC",        -- Regenerative Expulsion
  [306978] = "CC",        -- Madness Bomb
  [306985] = "CC",        -- Insanity Bomb
  [307071] = "Immune",      -- Synthesis
  [307061] = "Snare",       -- Mycelial Growth
  [317164] = "Immune",      -- Reactive Mass
  -- -- N'Zoth
  [308996] = "CC",        -- Servant of N'Zoth
  [310073] = "CC",        -- Mindgrasp
  [311392] = "CC",        -- Mindgrasp
  [314843] = "CC",        -- Corruptor's Gift
  [313793] = "CC",        -- Flames of Insanity
  [319353] = "CC",        -- Flames of Insanity
  [315675] = "CC",        -- Shattered Ego
  [315672] = "CC",        -- Shattered Ego
  [318976] = "CC",        -- Stupefying Glare
  [312155] = "CC",        -- Shattered Ego
  [310134] = "Immune",      -- Manifest Madness (99% damage reduction)
  ------------------------
  -- The Eternal Palace Raid
  -- -- Trash
  [303747] = "CC",        -- Ice Tomb
  [303396] = "Root",        -- Barbed Net
  [304189] = "Snare",       -- Frostbolt
  [303316] = "Snare",       -- Hindering Resonance
  -- -- Abyssal Commander Sivara
  [295807] = "CC",        -- Frozen
  [295850] = "CC",        -- Delirious
  [295704] = "CC",        -- Frost Bolt
  [295705] = "CC",        -- Toxic Bolt
  [300882] = "Root",        -- Inversion Sickness
  [300883] = "Root",        -- Inversion Sickness
  -- -- Radiance of Azshara
  [295916] = "Immune",      -- Ancient Tempest (damage taken reduced 99%)
  [296746] = "CC",        -- Arcane Bomb
  [304027] = "CC",        -- Arcane Bomb
  [296389] = "Immune",      -- Swirling Winds (damage taken reduced 99%)
  -- -- Lady Ashvane
  [297333] = "CC",        -- Briny Bubble
  [302992] = "CC",        -- Briny Bubble
  -- -- Orgozoa
  [305347] = "Immune",      -- Massive Incubator (damage taken reduced 90%)
  [295822] = "CC",        -- Conductive Pulse
  [305603] = "CC",        -- Electro Shock
  [304280] = "Immune",      -- Chaotic Growth (damage taken reduced 50%)
  [296914] = "Immune",      -- Chaotic Growth (damage taken reduced 50%)
  -- -- The Queen's Court
  [296704] = "Immune",      -- Separation of Power (damage taken reduced 99%)
  [296716] = "Immune",      -- Separation of Power (damage taken reduced 99%)
  [304410] = "Silence",     -- Repeat Performance
  [301832] = "CC",        -- Fanatical Zeal
  -- -- Za'qul, Harbinger of Ny'alotha
  [300133] = "CC",        -- Snapped
  [294545] = "CC",        -- Portal of Madness
  [292963] = "CC",        -- Dread
  [302503] = "CC",        -- Dread
  [303619] = "CC",        -- Dread
  [295327] = "CC",        -- Shattered Psyche
  [303832] = "CC",        -- Tentacle Slam
  [301117] = "Immune",      -- Dark Shield
  [296084] = "CC",        -- Mind Fracture
  [299705] = "CC",        -- Dark Passage
  [299591] = "Immune",      -- Shroud of Fear
  [303543] = "CC",        -- Dread Scream
  [296018] = "CC",        -- Manic Dread
  [302504] = "CC",        -- Manic Dread
  -- -- Queen Azshara
  [304759] = "CC",        -- Queen's Disgust
  [304763] = "CC",        -- Queen's Disgust
  [304760] = "Disarm",      -- Queen's Disgust
  [304770] = "Snare",       -- Queen's Disgust
  [304768] = "Snare",       -- Queen's Disgust
  [304757] = "Snare",       -- Queen's Disgust
  [298018] = "CC",        -- Frozen
  [299094] = "CC",        -- Beckon
  [302141] = "CC",        -- Beckon
  [303797] = "CC",        -- Beckon
  [303799] = "CC",        -- Beckon
  [300001] = "CC",        -- Devotion
  [303825] = "CC",        -- Crushing Depths
  [300620] = "Immune",      -- Crystalline Shield
  [303706] = "CC",        -- Song of Azshara
  ------------------------
  -- Crucible of Storms Raid
  -- -- Trash
  [293957] = "CC",        -- Maddening Gaze
  [295312] = "Immune",      -- Shadow Siphon
  [286754] = "CC",        -- Storm of Annihilation (damage done decreased by 50%)
  -- -- The Restless Cabal
  [282589] = "CC",        -- Cerebral Assault
  [285154] = "CC",        -- Cerebral Assault
  [282517] = "CC",        -- Terrifying Echo
  [287876] = "CC",        -- Enveloping Darkness (healing and damage done reduced by 99%)
  [282743] = "CC",        -- Storm of Annihilation (damage done decreased by 50%)
  -- -- Uu'nat
  [285562] = "CC",        -- Unknowable Terror
  [287693] = "Immune",      -- Sightless Bond (damage taken reduced by 99%)
  [286310] = "Immune",      -- Void Shield (damage taken reduced by 99%)
  [284601] = "CC",        -- Storm of Annihilation (damage done decreased by 50%)
  ------------------------
  -- Battle of Dazar'alor Raid
  -- -- Trash
  [289471] = "CC",        -- Terrifying Roar
  [286740] = "CC",        -- Light's Fury
  [289645] = "CC",        -- Polymorph
  [287325] = "CC",        -- Comet Storm
  [289772] = "CC",        -- Impale
  [289937] = "CC",        -- Thundering Slam
  [288842] = "CC",        -- Throw Goods
  [289419] = "CC",        -- Mass Hex
  [288815] = "CC",        -- Breath of Fire
  [287456] = "Root",        -- Frost Nova
  [289742] = "Immune",      -- Defense Field (damage taken reduced 75%)
  [287295] = "Snare",       -- Chilled
  -- -- Champion of the Light
  [288294] = "Immune",      -- Divine Protection (damage taken reduced 99%)
  [283651] = "CC",        -- Blinding Faith
  -- -- Grong
  [289406] = "CC",        -- Bestial Throw
  [289412] = "CC",        -- Bestial Impact
  [285998] = "CC",        -- Ferocious Roar
  [290575] = "CC",        -- Ferocious Roar
  -- -- Opulence
  [283609] = "CC",        -- Crush
  [283610] = "CC",        -- Crush
  -- -- Conclave of the Chosen
  [282079] = "Immune",      -- Loa's Pact (damage taken reduced 90%)
  [282135] = "CC",        -- Crawling Hex
  [290573] = "CC",        -- Crawling Hex
  [285879] = "CC",        -- Mind Wipe
  [265495] = "CC",        -- Static Orb
  [286838] = "CC",        -- Static Orb
  [282447] = "CC",        -- Kimbul's Wrath
  -- -- King Rastakhan
  [284995] = "CC",        -- Zombie Dust
  [284376] = "CC",        -- Death's Presence
  [284377] = "Immune",      -- Unliving
  -- -- High Tinker Mekkatorque
  [287167] = "CC",        -- Discombobulation
  [284214] = "CC",        -- Trample
  [289138] = "CC",        -- Trample
  [289644] = "Immune",      -- Spark Shield (damage taken reduced 99%)
  [282401] = "Immune",      -- Gnomish Force Shield (damage taken reduced 99%)
  [289248] = "Immune",      -- P.L.O.T Armor (damage taken reduced 99%)
  [282408] = "CC",        -- Spark Pulse (stun)
  [289232] = "CC",        -- Spark Pulse (hit chance reduced 100%)
  [289226] = "CC",        -- Spark Pulse (pacify)
  [286480] = "CC",        -- Anti-Tampering Shock
  [286516] = "CC",        -- Anti-Tampering Shock
  -- -- Stormwall Blockade
  [284121] = "Silence",     -- Thunderous Boom
  [286495] = "CC",        -- Tempting Song
  [284369] = "Snare",       -- Sea Storm
  -- -- Lady Jaina Proudmoore
  [287490] = "CC",        -- Frozen Solid
  [289963] = "CC",        -- Frozen Solid
  [285704] = "CC",        -- Frozen Solid
  [287199] = "Root",        -- Ring of Ice
  [287626] = "Root",        -- Grasp of Frost
  [288412] = "Root",        -- Hand of Frost
  [288434] = "Root",        -- Hand of Frost
  [289219] = "Root",        -- Frost Nova
  [289855] = "CC",        -- Frozen Siege
  [275809] = "CC",        -- Flash Freeze
  [271527] = "Immune",      -- Ice Block
  [287322] = "Immune",      -- Ice Block
  [282841] = "Immune",      -- Arctic Armor
  [287282] = "Immune",      -- Arctic Armor (damage taken reduced 90%)
  [287418] = "Immune",      -- Arctic Armor (damage taken reduced 90%)
  [288219] = "Immune",      -- Refractive Ice (damage taken reduced 99%)
  ------------------------
  -- Uldir Raid
  -- -- Trash
  [277498] = "CC",        -- Mind Slave
  [277358] = "CC",        -- Mind Flay
  [278890] = "CC",        -- Violent Hemorrhage
  [278967] = "CC",        -- Winged Charge
  [260275] = "CC",        -- Rumbling Stomp
  [262375] = "CC",        -- Bellowing Roar
  -- -- Taloc
  [271965] = "Immune",      -- Powered Down (damage taken reduced 99%)
  -- -- Fetid Devourer
  [277800] = "CC",        -- Swoop
  -- -- Zek'voz, Herald of N'zoth
  [265646] = "CC",        -- Will of the Corruptor
  [270589] = "CC",        -- Void Wail
  [270620] = "CC",        -- Psionic Blast
  -- -- Vectis
  [265212] = "CC",        -- Gestate
  -- -- Zul, Reborn
  [273434] = "CC",        -- Pit of Despair
  [269965] = "CC",        -- Pit of Despair
  [274271] = "CC",        -- Deathwish
  -- -- Mythrax the Unraveler
  [272407] = "CC",        -- Oblivion Sphere
  [284944] = "CC",        -- Oblivion Sphere
  [274230] = "Immune",      -- Oblivion Veil (damage taken reduced 99%)
  [276900] = "Immune",      -- Critical Mass (damage taken reduced 80%)
  -- -- G'huun
  [269691] = "CC",        -- Mind Thrall
  [273401] = "CC",        -- Mind Thrall
  [263504] = "CC",        -- Reorigination Blast
  [273251] = "CC",        -- Reorigination Blast
  [267700] = "CC",        -- Gaze of G'huun
  [255767] = "CC",        -- Grasp of G'huun
  [263217] = "Immune",      -- Blood Shield (not immune, but heals 5% of maximum health every 0.5 sec)
  [275129] = "Immune",      -- Corpulent Mass (damage taken reduced by 99%)
  [268174] = "Root",        -- Tendrils of Corruption
  [263235] = "Root",        -- Blood Feast
  [263321] = "Snare",       -- Undulating Mass
  [270287] = "Snare",       -- Blighted Ground
  ------------------------
  -- BfA World Bosses
  -- -- T'zane
  [261552] = "CC",        -- Terror Wail
  -- -- Hailstone Construct
  [274895] = "CC",        -- Freezing Tempest
  -- -- Warbringer Yenajz
  [274904] = "CC",        -- Reality Tear
  -- -- The Lion's Roar and Doom's Howl
  [271778] = "Snare",       -- Reckless Charge
  -- -- Ivus the Decayed
  [287554] = "Immune",      -- Petrify
  [282615] = "Immune",      -- Petrify
  -- -- Grand Empress Shek'zara
  [314306] = "CC",        -- Song of the Empress
  [314332] = "Immune",      -- Sound Barrier (damage taken reduced 70%)
  ------------------------
  -- Horrific Visions of N'zoth
  [317865] = "CC",        -- Emergency Cranial Defibrillation
  [304816] = "CC",        -- Emergency Cranial Defibrillation
  [291782] = "CC",        -- Controlled by the Vision
  [311558] = "ImmuneSpell",   -- Volatile Intent
  [306965] = "CC",        -- Shadow's Grasp
  [316510] = "CC",        -- Split Personality
  [306545] = "CC",        -- Haunting Shadows
  [288545] = "CC",        -- Fear (Madness: Terrified)
  [292240] = "Other",       -- Entomophobia
  [306583] = "Root",        -- Leaden Foot
  [288560] = "Snare",       -- Slowed
  [298514] = "CC",        -- Aqiri Mind Toxin
  [313639] = "CC",        -- Hex
  [305155] = "Snare",       -- Rupture
  [296510] = "Snare",       -- Creepy Crawler
  [78622]  = "CC",        -- Heroic Leap
  [314723] = "CC",        -- War Stomp
  [304969] = "CC",        -- Void Torrent
  [298033] = "CC",        -- Touch of the Abyss
  [299243] = "CC",        -- Touch of the Abyss
  [300530] = "CC",        -- Mind Carver
  [304634] = "CC",        -- Despair
  [297574] = "CC",        -- Hopelessness
  [283408] = "Snare",       -- Charge
  [304350] = "CC",        -- Mind Trap
  [299870] = "CC",        -- Mind Trap
  [306828] = "CC",        -- Defiled Ground
  [306726] = "CC",        -- Defiled Ground
  [297746] = "CC",        -- Seismic Slam
  [306646] = "CC",        -- Ring of Chaos
  [305378] = "CC",        -- Horrifying Shout
  [298630] = "CC",        -- Shockwave
  [297958] = "Snare",       -- Punishing Throw
  [314748] = "Snare",       -- Slow
  [298701] = "CC",        -- Chains of Servitude
  [298770] = "CC",        -- Chains of Servitude
  [309648] = "CC",        -- Tainted Polymorph
  [296674] = "Silence",     -- Lurking Appendage
  [308172] = "Snare",       -- Mind Flay
  [308375] = "CC",        -- Psychic Scream
  [306748] = "CC",        -- Psychic Scream
  [309882] = "CC",        -- Brutal Smash
  [298584] = "Immune",      -- Repel (not immune, 75% damage reduction)
  [312017] = "Immune",      -- Shrouded (not immune, 90% damage reduction)
  [308481] = "CC",        -- Rift Strike
  [308508] = "CC",        -- Rift Strike
  [308575] = "Immune",      -- Shadow Shift (not immune, 75% damage reduction)
  [311373] = "Snare",       -- Numbing Poison
  [283655] = "CC",        -- Cheap Shot
  [283106] = "ImmuneSpell",   -- Cloak of Shadows
  [283661] = "CC",        -- Kidney Shot
  [315254] = "Snare",       -- Harsh Lesson
  [315391] = "Snare",       -- Gladiator's Spite
  [311042] = "CC",        -- Evacuation Protocol
  [306552] = "CC",        -- Evacuation Protocol
  [306465] = "CC",        -- Evacuation Protocol
  [314916] = "CC",        -- Evacuation Protocol
  [302460] = "CC",        -- Evacuation Protocol
  [297286] = "CC",        -- Evacuation Protocol
  [311036] = "CC",        -- Evacuation Protocol
  [302493] = "CC",        -- Evacuation Protocol
  [311020] = "CC",        -- Evacuation Protocol
  [308654] = "Immune",      -- Shield Craggle (not immune, 90% damage reduction)
  ------------------------
  -- Visions of N'zoth Assaults (Uldum, Vale of Eternal Blossoms and Misc)
  [315818] = "CC",        -- Burning
  [250490] = "CC",        -- Animated Strike
  [317277] = "CC",        -- Storm Bolt
  [316508] = "CC",        -- Thunderous Charge
  [296820] = "CC",        -- Invoke Niuzao
  [308969] = "CC",        -- Dusted
  [166139] = "CC",        -- Blinding Radiance
  [308890] = "CC",        -- Shockwave
  [314193] = "CC",        -- Massive Shockwave
  [314191] = "CC",        -- Massive Shockwave
  [314880] = "CC",        -- Wave of Hysteria
  [312678] = "CC",        -- Insanity
  [312666] = "Other",       -- Soulbreak
  [314796] = "CC",        -- Bursting Darkness
  [157176] = "CC",        -- Grip of the Void
  [309398] = "CC",        -- Blinding Radiance
  [316997] = "CC",        -- Blinding Radiance
  [315892] = "Silence",     -- Void of Silence
  [314205] = "CC",        -- Maddening Gaze
  [314614] = "CC",        -- Fear of the Void
  [265721] = "Root",        -- Web Spray
  [93585]  = "CC",        -- Serum of Torment
  [316093] = "CC",        -- Terrifying Shriek
  [314458] = "ImmuneSpell",   -- Magnetic Field
  [315829] = "CC",        -- Evolution
  [314077] = "CC",        -- Psychic Assault
  [86699]  = "CC",        -- Shockwave
  [88846]  = "CC",        -- Shockwave
  [309696] = "CC",        -- Soul Wipe
  [316353] = "CC",        -- Shield Bash
  [310271] = "CC",        -- Bewildering Gaze
  [242085] = "CC",        -- Disoriented
  [242084] = "CC",        -- Fear
  [242088] = "CC",        -- Polymorph
  [242090] = "CC",        -- Sleep
  [296661] = "CC",        -- Stomp
  [306875] = "CC",        -- Electrostatic Burst
  [308886] = "Root",        -- Grasp of the Stonelord
  [313751] = "Snare",       -- Amber Burst
  [313934] = "Immune",      -- Sticky Shield
  [310239] = "CC",        -- Terror Gasp
  [81210]  = "Root",        -- Net
  [200434] = "CC",        -- Petrified!
  [309709] = "CC",        -- Petrified
  [312248] = "CC",        -- Amber Hibernation
  [305141] = "Immune",      -- Azerite-Hardened Carapace
  [317490] = "Snare",       -- Mind Flay
  [97154]  = "Snare",       -- Concussive Shot
  [126339] = "CC",        -- Shield Slam
  [126580] = "CC",        -- Crippling Blow
  [177578] = "CC",        -- Paralysis
  [314591] = "CC",        -- Flesh to Stone
  [314382] = "Silence",     -- Silence the Masses
  [312884] = "CC",        -- Heaving Blow
  [270444] = "Other",       -- Harden
  [309463] = "CC",        -- Crystalline
  [309889] = "Snare",       -- Grasp of N'Zoth
  [309411] = "Immune",      -- Gift of Stone
  [307327] = "Immune",      -- Expel Anima
  [312933] = "Immune",      -- Void's Embrace
  [306791] = "Immune",      -- Unexpected Results (not immune, 75% damage reduction)
  [307234] = "CC",        -- Disciple of N'Zoth
  [307786] = "CC",        -- Spirit Bind
  [154793] = "Root",        -- Spirit Bind
  [311522] = "CC",        -- Nightmarish Stare
  [306222] = "CC",        -- Critical Failure
  [304241] = "Root",        -- Distorting Reality
  [316940] = "CC",        -- Assassin Spawn
  [302338] = "CC",        -- Ice Trap
  [302591] = "CC",        -- Ice Trap
  [296810] = "Immune",      -- Fear of Death
  [313275] = "CC",        -- Cowardice
  [292451] = "CC",        -- Binding Shot
  [306769] = "CC",        -- Mutilate
  [302232] = "CC",        -- Crushing Charge
  [314301] = "CC",        -- Doom
  [299269] = "CC",        -- Eye Beam
  [314118] = "CC",        -- Glimpse of Infinity
  [306282] = "CC",        -- Knockdown
  [303403] = "CC",        -- Sap
  [296057] = "CC",        -- Seeker's Song
  [299485] = "CC",        -- Surging Shadows
  [311635] = "CC",        -- Throw Hefty Coin Sack
  [303193] = "CC",        -- Trample
  [313719] = "CC",        -- X-52 Personnel Armor: Overload
  [313311] = "CC",        -- Underhanded Punch
  [315850] = "CC",        -- Vomit
  ------------------------
  -- Battle for Darkshore
  [314516] = "CC",        -- Savage Charge
  [314519] = "CC",        -- Ravage
  [314884] = "CC",        -- Frozen Solid
  [7964]   = "CC",        -- Smoke Bomb
  [31274]  = "CC",        -- Knockdown
  [283921] = "CC",        -- Lancer's Charge
  [285708] = "CC",        -- Frozen Solid
  [288344] = "CC",        -- Massive Stomp
  [288339] = "CC",        -- Massive Stomp
  [286397] = "CC",        -- Massive Stomp
  [282676] = "CC",        -- Massive Stomp
  [212566] = "CC",        -- Terrifying Screech
  [283880] = "CC",        -- DRILL KILL
  [284949] = "CC",        -- Warden's Prison
  [22127]  = "Root",        -- Entangling Roots
  [31290]  = "Root",        -- Net
  [286404] = "Root",        -- Grasping Bramble
  [290013] = "Root",        -- Volatile Bulb
  [311761] = "Root",        -- Entangling Roots
  [311634] = "Root",        -- Entangling Roots
  [22356]  = "Snare",       -- Slow
  [284221] = "Snare",       -- Crippling Gash
  [194584] = "Snare",       -- Crippling Slash
  [284737] = "Snare",       -- Toxic Strike
  [289073] = "Snare",       -- Terrifying Screech
  [286510] = "Snare",       -- Nature's Force
  ------------------------
  -- Battle for Stromgarde
  [6524]   = "CC",        -- Ground Tremor
  [97933]  = "CC",        -- Intimidating Shout
  [273867] = "CC",        -- Intimidating Shout
  [262007] = "CC",        -- Polymorph
  [261488] = "CC",        -- Charge
  [264942] = "CC",        -- Scatter Shot
  [258186] = "CC",        -- Crushing Cleave
  [270411] = "CC",        -- Earthshatter
  [259833] = "CC",        -- Heroic Leap
  [259867] = "CC",        -- Storm Bolt
  [272856] = "CC",        -- Hex Bomb
  [266918] = "CC",        -- Fear
  [262362] = "CC",        -- Hex
  [253731] = "CC",        -- Massive Stomp
  [269674] = "CC",        -- Shattering Stomp
  [263665] = "CC",        -- Conflagration
  [210131] = "CC",        -- Trampling Charge
  [745]    = "Root",        -- Web
  [269680] = "Root",        -- Entanglement
  [262610] = "Root",        -- Weighted Net
  [20822]  = "Snare",       -- Frostbolt
  [141619] = "Snare",       -- Frostbolt
  [183081] = "Snare",       -- Frostbolt
  [266985] = "Snare",       -- Oil Slick
  [271001] = "Snare",       -- Poisoned Axe
  [273665] = "Snare",       -- Seismic Disturbance
  [278190] = "Snare",       -- Debilitating Infection
  [270089] = "Snare",       -- Frostbolt Volley
  [262538] = "Snare",       -- Thunder Clap
  [259850] = "Snare",       -- Reverberating Clap
  ------------------------
  -- BfA Island Expeditions
  [8377]   = "Root",        -- Earthgrab
  [270399] = "Root",        -- Unleashed Roots
  [270196] = "Root",        -- Chains of Light
  [267024] = "Root",        -- Stranglevines
  [236467] = "Root",        -- Pearlescent Clam
  [267025] = "Root",        -- Animal Trap
  [276807] = "Root",        -- Crude Net
  [276806] = "Root",        -- Stoutthistle
  [255311] = "Root",        -- Hurl Spear
  [8208]   = "CC",        -- Backhand
  [12461]  = "CC",        -- Backhand
  [276991] = "CC",        -- Backhand
  [280061] = "CC",        -- Brainsmasher Brew
  [280062] = "CC",        -- Unluckydo
  [267029] = "CC",        -- Glowing Seed
  [276808] = "CC",        -- Heavy Boulder
  [267028] = "CC",        -- Bright Lantern
  [276809] = "CC",        -- Crude Spear
  [276804] = "CC",        -- Crude Boomerang
  [267030] = "CC",        -- Heavy Crate
  [276805] = "CC",        -- Gloomspore Shroom
  [245638] = "CC",        -- Thick Shell
  [267026] = "CC",        -- Giant Flower
  [243576] = "CC",        -- Sticky Starfish
  [278818] = "CC",        -- Amber Entrapment
  [268345] = "CC",        -- Azerite Suppression
  [278813] = "CC",        -- Brain Freeze
  [272982] = "CC",        -- Bubble Trap
  [278823] = "CC",        -- Choking Mist
  [268343] = "CC",        -- Crystalline Stasis
  [268341] = "CC",        -- Cyclone
  [273392] = "CC",        -- Drakewing Bonds
  [278817] = "CC",        -- Drowning Waters
  [268337] = "CC",        -- Flash Freeze
  [278914] = "CC",        -- Ghostly Rune Prison
  [278822] = "CC",        -- Heavy Net
  [273612] = "CC",        -- Mental Fog
  [278820] = "CC",        -- Netted
  [278816] = "CC",        -- Paralyzing Pool
  [278811] = "CC",        -- Poisoned Water
  [278821] = "CC",        -- Sand Trap
  [274055] = "CC",        -- Sap
  [273914] = "CC",        -- Shadowy Conflagration
  [279986] = "CC",        -- Shrink Ray
  [278814] = "CC",        -- Sticky Ooze
  [259236] = "CC",        -- Stone Rune Prison
  [290626] = "CC",        -- Debilitating Howl
  [290625] = "CC",        -- Creeping Decay
  [290624] = "CC",        -- Necrotic Paralysis
  [290623] = "CC",        -- Stone Prison
  [245139] = "CC",        -- Petrified
  [274794] = "CC",        -- Hex
  [278808] = "CC",        -- Hex
  [278809] = "CC",        -- Hex
  [275651] = "CC",        -- Charge
  [262470] = "CC",        -- Blast-O-Matic Frag Bomb
  [262906] = "CC",        -- Arcane Charge
  [270460] = "CC",        -- Stone Eruption
  [262500] = "CC",        -- Crushing Charge
  [268203] = "CC",        -- Death Lens
  [244880] = "CC",        -- Charge
  [275087] = "CC",        -- Charge
  [262342] = "CC",        -- Hex
  [257748] = "CC",        -- Blind
  [262147] = "CC",        -- Wild Charge
  [262000] = "CC",        -- Wyvern Sting
  [258822] = "CC",        -- Blinding Peck
  [271227] = "CC",        -- Wildfire
  [244888] = "CC",        -- Bonk
  [273664] = "CC",        -- Crush
  [256600] = "CC",        -- Point Blank Blast
  [270457] = "CC",        -- Slam
  [258371] = "CC",        -- Crystal Gaze
  [266989] = "CC",        -- Swooping Charge
  [258390] = "CC",        -- Petrifying Gaze
  [275990] = "CC",        -- Conflagrating Exhaust
  [277375] = "CC",        -- Sucker Punch
  [278193] = "CC",        -- Crush
  [275671] = "CC",        -- Tremendous Roar
  [270459] = "CC",        -- Earth Blast
  [270461] = "CC",        -- Seismic Force
  [270463] = "CC",        -- Jagged Slash
  [275192] = "CC",        -- Blinding Sand
  [286907] = "CC",        -- Volatile Eruption
  [244988] = "CC",        -- Throw Boulder
  [244893] = "CC",        -- Throw Boulder
  [250505] = "CC",        -- Hysteria
  [285266] = "CC",        -- Asphyxiate
  [285270] = "CC",        -- Leg Sweep
  [275748] = "CC",        -- Paralyzing Fang
  [275997] = "CC",        -- Twilight Nova
  [270264] = "CC",        -- Meteor
  [277161] = "CC",        -- Shockwave
  [290764] = "CC",        -- Dragon Roar
  [286780] = "CC",        -- Terrifying Woof
  [276992] = "CC",        -- Big Foot Kick
  [277111] = "CC",        -- Serum of Torment
  [270248] = "CC",        -- Conflagrate
  [266151] = "CC",        -- Fire Bomb
  [265615] = "CC",        -- Icy Charge
  [186637] = "CC",        -- Grrlmmggr...
  [274758] = "CC",        -- Shrink (damage done reduced by 50%)
  [277118] = "CC",        -- Curse of Impotence (damage done reduced by 75%)
  --[262197] = "Immune",      -- Tenacity of the Pack (unkillable but not immune to damage)
  [264115] = "Immune",      -- Divine Shield
  [277040] = "Immune",      -- Soul of Mist (damage taken reduced 90%)
  [265445] = "Immune",      -- Shell Shield (damage taken reduced 75%)
  [267487] = "ImmunePhysical",  -- Icy Reflection
  [163671] = "Immune",      -- Ethereal
  [294375] = "CC",        -- Spiritflame
  [275154] = "Silence",     -- Silencing Calm
  [265723] = "Root",        -- Web
  [274801] = "Root",        -- Net
  [277115] = "Root",        -- Hooked Net
  [270613] = "Root",        -- Frost Nova
  [265584] = "Root",        -- Frost Nova
  [270705] = "Root",        -- Frozen Wave
  [265583] = "Root",        -- Grasping Claw
  [278176] = "Root",        -- Entangling Roots
  [278181] = "Root",        -- Wrapping Vines
  [275821] = "Root",        -- Earthen Hold
  [197720] = "Root",        -- Elder Charge
  [288473] = "Root",        -- Enslave
  [275052] = "Root",        -- Shocking Reins
  [277496] = "Root",        -- Spear Leap
  [85691]  = "Snare",       -- Piercing Howl
  [270285] = "Snare",       -- Blast Wave
  [277870] = "Snare",       -- Icy Venom
  [277109] = "Snare",       -- Sticky Stomp
  [266974] = "Snare",       -- Frostbolt
  [261962] = "Snare",       -- Brutal Whirlwind
  [258748] = "Snare",       -- Arctic Torrent
  [266286] = "Snare",       -- Tendon Rip
  [270606] = "Snare",       -- Frostbolt
  [294363] = "Snare",       -- Spirit Chains
  [266288] = "Snare",       -- Gnash
  [262465] = "Snare",       -- Bug Zapper
  [267195] = "Snare",       -- Slow
  [275038] = "Snare",       -- Icy Claw
  [274968] = "Snare",       -- Howl
  [273650] = "Snare",       -- Thorn Spray
  [256661] = "Snare",       -- Staggering Roar
  [256851] = "Snare",       -- Vile Spew
  [179021] = "Snare",       -- Slime
  [273124] = "Snare",       -- Lethargic Poison
  [205187] = "Snare",       -- Cripple
  [266158] = "Snare",       -- Frost Bomb
  [263344] = "Snare",       -- Subjugate
  [261095] = "Snare",       -- Vermin Parade
  [245386] = "Other",       -- Darkest Darkness (healing taken reduced by 99%)
  [274972] = "Other",       -- Breath of Darkness (healing taken reduced by 75%)
  ------------------------
  -- BfA Mythics
  -- -- Common
  [314483] = "CC",        -- Cascading Terror
  [314411] = "Other",       -- Lingering Doubt (casting speed reduced by 70%)
  [314308] = "Other",       -- Spirit Breaker (damage taken increased by 100%)
  [314392] = "Snare",       -- Vile Corruption
  [314592] = "Snare",       -- Mind Flay
  [314406] = "Snare",       -- Crippling Pestilence
  -- -- Operation: Mechagon
  [297283] = "CC",        -- Cave In
  [294995] = "CC",        -- Cave In
  [298259] = "CC",        -- Gooped
  [298124] = "CC",        -- Gooped
  [298718] = "CC",        -- Mega Taze
  [302681] = "CC",        -- Mega Taze
  [304452] = "CC",        -- Mega Taze
  [296150] = "CC",        -- Vent Blast
  [299994] = "CC",        -- Vent Blast
  [300650] = "CC",        -- Suffocating Smog
  [291974] = "CC",        -- Obnoxious Monologue
  [295130] = "CC",        -- Neutralize Threat
  [283640] = "CC",        -- Rattled
  [282943] = "CC",        -- Piston Smasher
  [285460] = "CC",        -- Discom-BOMB-ulator
  [299572] = "CC",        -- Shrink (damage and healing done reduced by 99%)
  [299707] = "CC",        -- Trample
  [296571] = "Immune",      -- Power Shield (damage taken reduced 99%)
  [295147] = "Immune",      -- Reflective Armor
  [293986] = "Silence",     -- Sonic Pulse
  [303264] = "CC",        -- Anti-Trespassing Field
  [296279] = "CC",        -- Anti-Trespassing Teleport
  [293724] = "Immune",      -- Shield Generator (damage taken reduced 75%)
  [300514] = "Immune",      -- Stoneskin (damage taken reduced 75%)
  [304074] = "Immune",      -- Stoneskin (damage taken reduced 75%)
  [295168] = "CC",        -- Capacitor Discharge
  [295170] = "CC",        -- Capacitor Discharge
  [295182] = "CC",        -- Capacitor Discharge
  [295183] = "CC",        -- Capacitor Discharge
  [300436] = "Root",        -- Grasping Hex
  [299475] = "Snare",       -- B.O.R.K
  [300764] = "Snare",       -- Slimebolt
  [296560] = "Snare",       -- Clinging Static
  [285388] = "Snare",       -- Vent Jets
  [298602] = "Immune",      -- Smoke Cloud (interferes with targeting)
  [300675] = "Other",       -- Toxic Fog
  [296080] = "Other",       -- Haywire
  [300011] = "Immune",      -- Force Shield
  -- -- Atal'Dazar
  [255371] = "CC",        -- Terrifying Visage
  [255041] = "CC",        -- Terrifying Screech
  [252781] = "CC",        -- Unstable Hex
  [279118] = "CC",        -- Unstable Hex
  [252692] = "CC",        -- Waylaying Jab
  [255567] = "CC",        -- Frenzied Charge
  [258653] = "Immune",      -- Bulwark of Juju (90% damage reduction)
  [253721] = "Immune",      -- Bulwark of Juju (90% damage reduction)
  [255971] = "Other",       -- Bad Voodoo
  [255960] = "Other",       -- Bad Voodoo
  [255967] = "Other",       -- Bad Voodoo
  [255968] = "Other",       -- Bad Voodoo
  [255970] = "Other",       -- Bad Voodoo
  [255972] = "Other",       -- Bad Voodoo
  [272618] = "Other",       -- Bad Voodoo
  -- -- Kings' Rest
  [268796] = "CC",        -- Impaling Spear
  [269369] = "CC",        -- Deathly Roar
  [267702] = "CC",        -- Entomb
  [271555] = "CC",        -- Entomb
  [270920] = "CC",        -- Seduction
  [270003] = "CC",        -- Suppression Slam
  [270492] = "CC",        -- Hex
  [276031] = "CC",        -- Pit of Despair
  [267626] = "CC",        -- Dessication (damage done reduced by 50%)
  [270931] = "Snare",       -- Darkshot
  [270499] = "Snare",       -- Frost Shock
  -- -- The MOTHERLODE!!
  [257337] = "CC",        -- Shocking Claw
  [257371] = "CC",        -- Tear Gas
  [275907] = "CC",        -- Tectonic Smash
  [280605] = "CC",        -- Brain Freeze
  [263637] = "CC",        -- Clothesline
  [268797] = "CC",        -- Transmute: Enemy to Goo
  [268846] = "Silence",     -- Echo Blade
  [267367] = "CC",        -- Deactivated
  [278673] = "CC",        -- Red Card
  [278644] = "CC",        -- Slide Tackle
  [257481] = "CC",        -- Fracking Totem
  [269278] = "CC",        -- Panic!
  [260189] = "Immune",      -- Configuration: Drill (damage taken reduced 99%)
  [268704] = "Snare",       -- Furious Quake
  -- -- Shrine of the Storm
  [268027] = "CC",        -- Rising Tides
  [276268] = "CC",        -- Heaving Blow
  [269131] = "CC",        -- Ancient Mindbender
  [268059] = "Root",        -- Anchor of Binding
  [269419] = "Silence",     -- Yawning Gate
  [267956] = "CC",        -- Zap
  [269104] = "CC",        -- Explosive Void
  [268391] = "CC",        -- Mental Assault
  [269289] = "CC",        -- Disciple of the Vol'zith
  [264526] = "Root",        -- Grasp from the Depths
  [276767] = "ImmuneSpell",   -- Consuming Void
  [268375] = "ImmunePhysical",  -- Detect Thoughts
  [267982] = "Immune",      -- Protective Gaze (damage taken reduced 75%)
  [268212] = "Immune",      -- Minor Reinforcing Ward (damage taken reduced 75%)
  [268186] = "Immune",      -- Reinforcing Ward (damage taken reduced 75%)
  [267904] = "Immune",      -- Reinforcing Ward (damage taken reduced 75%)
  [267901] = "Snare",       -- Blessing of Ironsides
  [274631] = "Snare",       -- Lesser Blessing of Ironsides
  [267899] = "Snare",       -- Hindering Cleave
  [268896] = "Snare",       -- Mind Rend
  -- -- Temple of Sethraliss
  [280032] = "CC",        -- Neurotoxin
  [268993] = "CC",        -- Cheap Shot
  [268008] = "CC",        -- Snake Charm
  [263958] = "CC",        -- A Knot of Snakes
  [269970] = "CC",        -- Blinding Sand
  [256333] = "CC",        -- Dust Cloud (0% chance to hit)
  [260792] = "CC",        -- Dust Cloud (0% chance to hit)
  [269670] = "Immune",      -- Empowerment (90% damage reduction)
  [261635] = "Immune",      -- Stoneshield Potion
  [273274] = "Snare",       -- Polarized Field
  [275566] = "Snare",       -- Numb Hands
  -- -- Waycrest Manor
  [265407] = "Silence",     -- Dinner Bell
  [263891] = "CC",        -- Grasping Thorns
  [260900] = "CC",        -- Soul Manipulation
  [260926] = "CC",        -- Soul Manipulation
  [265352] = "CC",        -- Toad Blight
  [264390] = "Silence",     -- Spellbind
  [278468] = "CC",        -- Freezing Trap
  [267907] = "CC",        -- Soul Thorns
  [265346] = "CC",        -- Pallid Glare
  [268202] = "CC",        -- Death Lens
  [261265] = "Immune",      -- Ironbark Shield (99% damage reduction)
  [261266] = "Immune",      -- Runic Ward (99% damage reduction)
  [261264] = "Immune",      -- Soul Armor (99% damage reduction)
  [271590] = "Immune",      -- Soul Armor (99% damage reduction)
  [260923] = "Immune",      -- Soul Manipulation (99% damage reduction)
  [264027] = "Immune",      -- Warding Candles (50% damage reduction)
  [264040] = "Snare",       -- Uprooted Thorns
  [264712] = "Snare",       -- Rotten Expulsion
  [261440] = "Snare",       -- Virulent Pathogen
  -- -- Tol Dagor
  [258058] = "Root",        -- Squeeze
  [259711] = "Root",        -- Lockdown
  [258313] = "CC",        -- Handcuff (Pacified and Silenced)
  [260067] = "CC",        -- Vicious Mauling
  [257791] = "CC",        -- Howling Fear
  [257793] = "CC",        -- Smoke Powder
  [257119] = "CC",        -- Sand Trap
  [256474] = "CC",        -- Heartstopper Venom
  [258128] = "CC",        -- Debilitating Shout (damage done reduced by 50%)
  [258317] = "ImmuneSpell",   -- Riot Shield (-75% spell damage and redirect spells to the caster)
  [258153] = "Immune",      -- Watery Dome (75% damage redictopm)
  [265271] = "Snare",       -- Sewer Slime
  [257777] = "Snare",       -- Crippling Shiv
  [259188] = "Snare",       -- Heavily Armed
  -- -- Freehold
  [274516] = "CC",        -- Slippery Suds
  [257949] = "CC",        -- Slippery
  [258875] = "CC",        -- Blackout Barrel
  [274400] = "CC",        -- Duelist Dash
  [274389] = "Root",        -- Rat Traps
  [276061] = "CC",        -- Boulder Throw
  [258182] = "CC",        -- Boulder Throw
  [268283] = "CC",        -- Obscured Vision (hit chance decreased 75%)
  [257274] = "Snare",       -- Vile Coating
  [257478] = "Snare",       -- Crippling Bite
  [257747] = "Snare",       -- Earth Shaker
  [257784] = "Snare",       -- Frost Blast
  [272554] = "Snare",       -- Bloody Mess
  -- -- Siege of Boralus
  [256957] = "Immune",      -- Watertight Shell
  [257069] = "CC",        -- Watertight Shell
  [261428] = "CC",        -- Hangman's Noose
  [257292] = "CC",        -- Heavy Slash
  [272874] = "CC",        -- Trample
  [257169] = "CC",        -- Terrifying Roar
  [274942] = "CC",        -- Banana Rampage
  [272571] = "Silence",     -- Choking Waters
  [275826] = "Immune",      -- Bolstering Shout (damage taken reduced 75%)
  [270624] = "Root",        -- Crushing Embrace
  [272834] = "Snare",       -- Viscous Slobber
  -- -- The Underrot
  [265377] = "Root",        -- Hooked Snare
  [272609] = "CC",        -- Maddening Gaze
  [265511] = "CC",        -- Spirit Drain
  [278961] = "CC",        -- Decaying Mind
  [269406] = "CC",        -- Purge Corruption
  [258347] = "Silence",     -- Sonic Screech
  ------------------------
  ---- PVE LEGION
  ------------------------
  -- EN Raid
  -- -- Trash
  [223914] = "CC",        -- Intimidating Roar
  [225249] = "CC",        -- Devastating Stomp
  [225073] = "Root",        -- Despoiling Roots
  [222719] = "Root",        -- Befoulment
  -- -- Nythendra
  [205043] = "CC",        -- Infested Mind (Nythendra)
  -- -- Ursoc
  [197980] = "CC",        -- Nightmarish Cacophony (Ursoc)
  -- -- Dragons of Nightmare
  [205341] = "CC",        -- Seeping Fog (Dragons of Nightmare)
  [225356] = "CC",        -- Seeping Fog (Dragons of Nightmare)
  [203110] = "CC",        -- Slumbering Nightmare (Dragons of Nightmare)
  [204078] = "CC",        -- Bellowing Roar (Dragons of Nightmare)
  [203770] = "Root",        -- Defiled Vines (Dragons of Nightmare)
  -- -- Il'gynoth
  [212886] = "CC",        -- Nightmare Corruption (Il'gynoth)
  -- -- Cenarius
  [210315] = "Root",        -- Nightmare Brambles (Cenarius)
  [214505] = "CC",        -- Entangling Nightmares (Cenarius)
  ------------------------
  -- ToV Raid
  -- -- Trash
  [228609] = "CC",        -- Bone Chilling Scream
  [228883] = "CC",        -- Unholy Reckoning
  [228869] = "CC",        -- Crashing Waves
  -- -- Odyn
  [228018] = "Immune",      -- Valarjar's Bond (Odyn)
  [229529] = "Immune",      -- Valarjar's Bond (Odyn)
  [227781] = "CC",        -- Glowing Fragment (Odyn)
  [227594] = "Immune",      -- Runic Shield (Odyn)
  [227595] = "Immune",      -- Runic Shield (Odyn)
  [227596] = "Immune",      -- Runic Shield (Odyn)
  [227597] = "Immune",      -- Runic Shield (Odyn)
  [227598] = "Immune",      -- Runic Shield (Odyn)
  -- -- Guarm
  [228248] = "CC",        -- Frost Lick (Guarm)
  -- -- Helya
  [232350] = "CC",        -- Corrupted (Helya)
  ------------------------
  -- NH Raid
  -- -- Trash
  [225583] = "CC",        -- Arcanic Release
  [225803] = "Silence",     -- Sealed Magic
  [224483] = "CC",        -- Slam
  [224944] = "CC",        -- Will of the Legion
  [224568] = "CC",        -- Mass Suppress
  [221524] = "Immune",      -- Protect (not immune, 90% less dmg)
  [226231] = "Immune",      -- Faint Hope
  [230377] = "CC",        -- Wailing Bolt
  -- -- Skorpyron
  [204483] = "CC",        -- Focused Blast (Skorpyron)
  -- -- Spellblade Aluriel
  [213621] = "CC",        -- Entombed in Ice (Spellblade Aluriel)
  -- -- Tichondrius
  [215988] = "CC",        -- Carrion Nightmare (Tichondrius)
  -- -- High Botanist Tel'arn
  [218304] = "Root",        -- Parasitic Fetter (Botanist)
  -- -- Star Augur
  [206603] = "CC",        -- Frozen Solid (Star Augur)
  [216697] = "CC",        -- Frigid Pulse (Star Augur)
  [207720] = "CC",        -- Witness the Void (Star Augur)
  [207714] = "Immune",      -- Void Shift (-99% dmg taken) (Star Augur)
  -- -- Gul'dan
  [206366] = "CC",        -- Empowered Bonds of Fel (Knockback Stun) (Gul'dan)
  [206983] = "CC",        -- Shadowy Gaze (Gul'dan)
  [208835] = "CC",        -- Distortion Aura (Gul'dan)
  [208671] = "CC",        -- Carrion Wave (Gul'dan)
  [229951] = "CC",        -- Fel Obelisk (Gul'dan)
  [206841] = "CC",        -- Fel Obelisk (Gul'dan)
  [227749] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [227750] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [227743] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [227745] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [227427] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [227320] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  [206516] = "Immune",      -- The Eye of Aman'Thul (Gul'dan)
  ------------------------
  -- ToS Raid
  -- -- Trash
  [243298] = "CC",        -- Lash of Domination
  [240706] = "CC",        -- Arcane Ward
  [240737] = "CC",        -- Polymorph Bomb
  [239810] = "CC",        -- Sever Soul
  [240592] = "CC",        -- Serpent Rush
  [240169] = "CC",        -- Electric Shock
  [241234] = "CC",        -- Darkening Shot
  [241009] = "CC",        -- Power Drain (-90% damage)
  [241254] = "CC",        -- Frost-Fingered Fear
  [241276] = "CC",        -- Icy Tomb
  [241348] = "CC",        -- Deafening Wail
  -- -- Demonic Inquisition
  [233430] = "CC",        -- Unbearable Torment (Demonic Inquisition) (no CC, -90% dmg, -25% heal, +90% dmg taken)
  -- -- Harjatan
  [240315] = "Immune",      -- Hardened Shell (Harjatan)
  -- -- Sisters of the Moon
  [237351] = "Silence",     -- Lunar Barrage (Sisters of the Moon)
  -- -- Mistress Sassz'ine
  [234332] = "CC",        -- Hydra Acid (Mistress Sassz'ine)
  [230362] = "CC",        -- Thundering Shock (Mistress Sassz'ine)
  [230959] = "CC",        -- Concealing Murk (Mistress Sassz'ine) (no CC, hit chance reduced 75%)
  -- -- The Desolate Host
  [236241] = "CC",        -- Soul Rot (The Desolate Host) (no CC, dmg dealt reduced 75%)
  [236011] = "Silence",     -- Tormented Cries (The Desolate Host)
  [236513] = "Immune",      -- Bonecage Armor (The Desolate Host) (75% dmg reduction)
  -- -- Maiden of Vigilance
  [248812] = "CC",        -- Blowback (Maiden of Vigilance)
  [233739] = "CC",        -- Malfunction (Maiden of Vigilance
  -- -- Kil'jaeden
  [245332] = "Immune",      -- Nether Shift (Kil'jaeden)
  [244834] = "Immune",      -- Nether Gale (Kil'jaeden)
  [236602] = "CC",        -- Soul Anguish (Kil'jaeden)
  [236555] = "CC",        -- Deceiver's Veil (Kil'jaeden)
  ------------------------
  -- Antorus Raid
  -- -- Trash
  [246209] = "CC",        -- Punishing Flame
  [254502] = "CC",        -- Fearsome Leap
  [254125] = "CC",        -- Cloud of Confusion
  -- -- Garothi Worldbreaker
  [246920] = "CC",        -- Haywire Decimation
  -- -- Hounds of Sargeras
  [244086] = "CC",        -- Molten Touch
  [244072] = "CC",        -- Molten Touch
  [249227] = "CC",        -- Molten Touch
  [249241] = "CC",        -- Molten Touch
  [244071] = "CC",        -- Weight of Darkness
  -- -- War Council
  [244748] = "CC",        -- Shocked
  -- -- Portal Keeper Hasabel
  [246208] = "Root",        -- Acidic Web
  [244949] = "CC",        -- Felsilk Wrap
  -- -- Imonar the Soulhunter
  [247641] = "CC",        -- Stasis Trap
  [255029] = "CC",        -- Sleep Canister
  [247565] = "CC",        -- Slumber Gas
  [250135] = "Immune",      -- Conflagration (-99% damage taken)
  [248233] = "Immune",      -- Conflagration (-99% damage taken)
  -- -- Kin'garoth
  [246516] = "Immune",      -- Apocalypse Protocol (-99% damage taken)
  -- -- The Coven of Shivarra
  [253203] = "Immune",      -- Shivan Pact (-99% damage taken)
  [249863] = "Immune",      -- Visage of the Titan
  [256356] = "CC",        -- Chilled Blood
  -- -- Aggramar
  [244894] = "Immune",      -- Corrupt Aegis
  [246014] = "CC",        -- Searing Tempest
  [255062] = "CC",        -- Empowered Searing Tempest
  ------------------------
  -- The Deaths of Chromie Scenario
  [246941] = "CC",        -- Looming Shadows
  [245167] = "CC",        -- Ignite
  [248839] = "CC",        -- Charge
  [246211] = "CC",        -- Shriek of the Graveborn
  [247683] = "Root",        -- Deep Freeze
  [247684] = "CC",        -- Deep Freeze
  [244959] = "CC",        -- Time Stop
  [248516] = "CC",        -- Sleep
  [245169] = "Immune",      -- Reflective Shield
  [248716] = "CC",        -- Infernal Strike
  [247730] = "Root",        -- Faith's Fetters
  [245822] = "CC",        -- Inescapable Nightmare
  [245126] = "Silence",     -- Soul Burn
  ------------------------
  -- Legion Mythics
  -- -- The Arcway
  [195804] = "CC",        -- Quarantine
  [203649] = "CC",        -- Exterminate
  [203957] = "CC",        -- Time Lock
  [211543] = "Root",        -- Devour
  -- -- Black Rook Hold
  [194960] = "CC",        -- Soul Echoes
  [197974] = "CC",        -- Bonecrushing Strike
  [199168] = "CC",        -- Itchy!
  [204954] = "CC",        -- Cloud of Hypnosis
  [199141] = "CC",        -- Cloud of Hypnosis
  [199097] = "CC",        -- Cloud of Hypnosis
  [214002] = "CC",        -- Raven's Dive
  [200261] = "CC",        -- Bonebreaking Strike
  [201070] = "CC",        -- Dizzy
  [221117] = "CC",        -- Ghastly Wail
  [222417] = "CC",        -- Boulder Crush
  [221838] = "CC",        -- Disorienting Gas
  -- -- Court of Stars
  [207278] = "Snare",       -- Arcane Lockdown
  [207261] = "CC",        -- Resonant Slash
  [215204] = "CC",        -- Hinder
  [207979] = "CC",        -- Shockwave
  [224333] = "CC",        -- Enveloping Winds
  [209404] = "Silence",     -- Seal Magic
  [209413] = "Silence",     -- Suppress
  [209027] = "CC",        -- Quelling Strike
  [212773] = "CC",        -- Subdue
  [216000] = "CC",        -- Mighty Stomp
  [213233] = "CC",        -- Uninvited Guest
  -- -- Return to Karazhan
  [227567] = "CC",        -- Knocked Down
  [228215] = "CC",        -- Severe Dusting
  [227508] = "CC",        -- Mass Repentance
  [227545] = "CC",        -- Mana Drain
  [227909] = "CC",        -- Ghost Trap
  [228693] = "CC",        -- Ghost Trap
  [228837] = "CC",        -- Bellowing Roar
  [227592] = "CC",        -- Frostbite
  [228239] = "CC",        -- Terrifying Wail
  [241774] = "CC",        -- Shield Smash
  [230122] = "Silence",     -- Garrote - Silence
  [39331]  = "Silence",     -- Game In Session
  [227977] = "CC",        -- Flashlight
  [241799] = "CC",        -- Seduction
  [227917] = "CC",        -- Poetry Slam
  [230083] = "CC",        -- Nullification
  [229489] = "Immune",      -- Royalty (90% dmg reduction)
  -- -- Maw of Souls
  [193364] = "CC",        -- Screams of the Dead
  [198551] = "CC",        -- Fragment
  [197653] = "CC",        -- Knockdown
  [198405] = "CC",        -- Bone Chilling Scream
  [193215] = "CC",        -- Kvaldir Cage
  [204057] = "CC",        -- Kvaldir Cage
  [204058] = "CC",        -- Kvaldir Cage
  [204059] = "CC",        -- Kvaldir Cage
  [204060] = "CC",        -- Kvaldir Cage
  -- -- Vault of the Wardens
  [202455] = "Immune",      -- Void Shield
  [212565] = "CC",        -- Inquisitive Stare
  [225416] = "CC",        -- Intercept
  [6726]   = "Silence",     -- Silence
  [201488] = "CC",        -- Frightening Shout
  [203774] = "Immune",      -- Focusing
  [192517] = "CC",        -- Brittle
  [201523] = "CC",        -- Brittle
  [194323] = "CC",        -- Petrified
  [206387] = "CC",        -- Steal Light
  [197422] = "Immune",      -- Creeping Doom
  [210138] = "CC",        -- Fully Petrified
  [202615] = "Root",        -- Torment
  [193069] = "CC",        -- Nightmares
  [191743] = "Silence",     -- Deafening Screech
  [202658] = "CC",        -- Drain
  [193969] = "Root",        -- Razors
  [204282] = "CC",        -- Dark Trap
  -- -- Eye of Azshara
  [191975] = "CC",        -- Impaling Spear
  [191977] = "CC",        -- Impaling Spear
  [193597] = "CC",        -- Static Nova
  [192708] = "CC",        -- Arcane Bomb
  [195561] = "CC",        -- Blinding Peck
  [195129] = "CC",        -- Thundering Stomp
  [195253] = "CC",        -- Imprisoning Bubble
  [197144] = "Root",        -- Hooked Net
  [197105] = "CC",        -- Polymorph: Fish
  [195944] = "CC",        -- Rising Fury
  -- -- Darkheart Thicket
  [200329] = "CC",        -- Overwhelming Terror
  [200273] = "CC",        -- Cowardice
  [204246] = "CC",        -- Tormenting Fear
  [200631] = "CC",        -- Unnerving Screech
  [200771] = "CC",        -- Propelling Charge
  [199063] = "Root",        -- Strangling Roots
  -- -- Halls of Valor
  [198088] = "CC",        -- Glowing Fragment
  [215429] = "CC",        -- Thunderstrike
  [199340] = "CC",        -- Bear Trap
  [210749] = "CC",        -- Static Storm
  -- -- Neltharion's Lair
  [200672] = "CC",        -- Crystal Cracked
  [202181] = "CC",        -- Stone Gaze
  [193585] = "CC",        -- Bound
  [186616] = "CC",        -- Petrified
  -- -- Cathedral of Eternal Night
  [238678] = "Silence",     -- Stifling Satire
  [238484] = "CC",        -- Beguiling Biography
  [242724] = "CC",        -- Dread Scream
  [239217] = "CC",        -- Blinding Glare
  [238583] = "Silence",     -- Devour Magic
  [239156] = "CC",        -- Book of Eternal Winter
  [240556] = "Silence",     -- Tome of Everlasting Silence
  [242792] = "CC",        -- Vile Roots
  -- -- The Seat of the Triumvirate
  [246913] = "Immune",      -- Void Phased
  [244621] = "CC",        -- Void Tear
  [248831] = "CC",        -- Dread Screech
  [246026] = "CC",        -- Void Trap
  [245278] = "CC",        -- Void Trap
  [244751] = "CC",        -- Howling Dark
  [248804] = "Immune",      -- Dark Bulwark
  [247816] = "CC",        -- Backlash
  [254020] = "Immune",      -- Darkened Shroud
  [253952] = "CC",        -- Terrifying Howl
  [248298] = "Silence",     -- Screech
  [245706] = "CC",        -- Ruinous Strike
  [248133] = "CC",        -- Stygian Blast
  ------------------------
  ---- PVE CLASSIC
  ------------------------
  -- Molten Core Raid
  -- -- Trash
  [19364]  = "CC",        -- Ground Stomp
  [19369]  = "CC",        -- Ancient Despair
  [19641]  = "CC",        -- Pyroclast Barrage
  [20276]  = "CC",        -- Knockdown
  [19393]  = "Silence",     -- Soul Burn
  [19636]  = "Root",        -- Fire Blossom
  -- -- Lucifron
  [20604]  = "CC",        -- Dominate Mind
  -- -- Magmadar
  [19408]  = "CC",        -- Panic
  -- -- Gehennas
  [20277]  = "CC",        -- Fist of Ragnaros
  [19716]  = "Other",       -- Gehennas' Curse
  -- -- Garr
  [19496]  = "Snare",       -- Magma Shackles
  -- -- Shazzrah
  [19714]  = "ImmuneSpell",   -- Deaden Magic (not immune, 50% magical damage reduction)
  -- -- Golemagg the Incinerator
  [19820]  = "Snare",       -- Mangle
  [22689]  = "Snare",       -- Mangle
  -- -- Sulfuron Harbinger
  [19780]  = "CC",        -- Hand of Ragnaros
  -- -- Majordomo Executus
  [20619]  = "ImmuneSpell",   -- Magic Reflection (not immune, 50% chance reflect spells)
  [20229]  = "Snare",       -- Blast Wave
  ------------------------
  -- Onyxia's Lair Raid
  -- -- Onyxia
  [18431]  = "CC",        -- Bellowing Roar
  ------------------------
  -- Blackwing Lair Raid
  -- -- Trash
  [24375]  = "CC",        -- War Stomp
  [22289]  = "CC",        -- Brood Power: Green
  [22291]  = "CC",        -- Brood Power: Bronze
  [22561]  = "CC",        -- Brood Power: Green
  [22247]  = "Snare",       -- Suppression Aura
  [22424]  = "Snare",       -- Blast Wave
  [15548]  = "Snare",       -- Thunderclap
  -- -- Razorgore the Untamed
  [19872]  = "CC",        -- Calm Dragonkin
  [23023]  = "CC",        -- Conflagration
  [15593]  = "CC",        -- War Stomp
  [16740]  = "CC",        -- War Stomp
  [24375]  = "CC",        -- War Stomp
  [28725]  = "CC",        -- War Stomp
  [14515]  = "CC",        -- Dominate Mind
  [22274]  = "CC",        -- Greater Polymorph
  [13747]  = "Snare",       -- Slow
  -- -- Broodlord Lashlayer
  [23331]  = "Snare",       -- Blast Wave
  [25049]  = "Snare",       -- Blast Wave
  -- -- Chromaggus
  [23310]  = "CC",        -- Time Lapse
  [23312]  = "CC",        -- Time Lapse
  [23174]  = "CC",        -- Chromatic Mutation
  [23171]  = "CC",        -- Time Stop (Brood Affliction: Bronze)
  [23153]  = "Snare",       -- Brood Affliction: Blue
  [23169]  = "Other",       -- Brood Affliction: Green
  -- -- Nefarian
  [22666]  = "Silence",     -- Silence
  [22667]  = "CC",        -- Shadow Command
  [22663]  = "Immune",      -- Nefarian's Barrier
  [22686]  = "CC",        -- Bellowing Roar
  [39427]  = "CC",        -- Bellowing Roar
  [22678]  = "CC",        -- Fear
  [23603]  = "CC",        -- Wild Polymorph
  [23364]  = "CC",        -- Tail Lash
  [23365]  = "Disarm",      -- Dropped Weapon
  [23415]  = "ImmunePhysical",  -- Improved Blessing of Protection
  [23414]  = "Root",        -- Paralyze
  [22687]  = "Other",       -- Veil of Shadow
  ------------------------
  -- Zul'Gurub Raid
  -- -- Trash
  [24619]  = "Silence",     -- Soul Tap
  [24048]  = "CC",        -- Whirling Trip
  [24600]  = "CC",        -- Web Spin
  [24335]  = "CC",        -- Wyvern Sting
  [24020]  = "CC",        -- Axe Flurry
  [24671]  = "CC",        -- Snap Kick
  [24333]  = "CC",        -- Ravage
  [6869]   = "CC",        -- Fall down
  [24053]  = "CC",        -- Hex
  [24021]  = "ImmuneSpell",   -- Anti-Magic Shield
  [24674]  = "Other",       -- Veil of Shadow
  [24002]  = "Snare",       -- Tranquilizing Poison
  [24003]  = "Snare",       -- Tranquilizing Poison
  -- -- High Priestess Jeklik
  [23918]  = "Silence",     -- Sonic Burst
  [22884]  = "CC",        -- Psychic Scream
  [22911]  = "CC",        -- Charge
  [23919]  = "CC",        -- Swoop
  [26044]  = "CC",        -- Mind Flay
  -- -- High Priestess Mar'li
  [24110]  = "Silence",     -- Enveloping Webs
  -- -- High Priest Thekal
  [21060]  = "CC",        -- Blind
  [12540]  = "CC",        -- Gouge
  [24193]  = "CC",        -- Charge
  -- -- Bloodlord Mandokir & Ohgan
  [24408]  = "CC",        -- Charge
  -- -- Gahz'ranka
  [16099]  = "Snare",       -- Frost Breath
  -- -- Jin'do the Hexxer
  [17172]  = "CC",        -- Hex
  [24261]  = "CC",        -- Brain Wash
  -- -- Edge of Madness: Gri'lek, Hazza'rah, Renataki, Wushoolay
  [24648]  = "Root",        -- Entangling Roots
  [24664]  = "CC",        -- Sleep
  -- -- Hakkar
  [24687]  = "Silence",     -- Aspect of Jeklik
  [24686]  = "CC",        -- Aspect of Mar'li
  [24690]  = "CC",        -- Aspect of Arlokk
  [24327]  = "CC",        -- Cause Insanity
  [24178]  = "CC",        -- Will of Hakkar
  [24322]  = "CC",        -- Blood Siphon
  [24323]  = "CC",        -- Blood Siphon
  [24324]  = "CC",        -- Blood Siphon
  ------------------------
  -- Ruins of Ahn'Qiraj Raid
  -- -- Trash
  [25371]  = "CC",        -- Consume
  [25654]  = "CC",        -- Tail Lash
  [25515]  = "CC",        -- Bash
  [25187]  = "Snare",       -- Hive'Zara Catalyst
  -- -- Kurinnaxx
  [25656]  = "CC",        -- Sand Trap
  -- -- General Rajaxx
  [19134]  = "CC",        -- Intimidating Shout
  [29544]  = "CC",        -- Intimidating Shout
  [25425]  = "CC",        -- Shockwave
  [25282]  = "Immune",      -- Shield of Rajaxx
  -- -- Moam
  [25685]  = "CC",        -- Energize
  -- -- Ayamiss the Hunter
  [25852]  = "CC",        -- Lash
  [6608]   = "Disarm",      -- Dropped Weapon
  [25725]  = "CC",        -- Paralyze
  -- -- Ossirian the Unscarred
  [25189]  = "CC",        -- Enveloping Winds
  ------------------------
  -- Temple of Ahn'Qiraj Raid
  -- -- Trash
  [18327]  = "Silence",     -- Silence
  [26069]  = "Silence",     -- Silence
  [26070]  = "CC",        -- Fear
  [26072]  = "CC",        -- Dust Cloud
  [25698]  = "CC",        -- Explode
  [26079]  = "CC",        -- Cause Insanity
  [26049]  = "CC",        -- Mana Burn
  [26552]  = "CC",        -- Nullify
  [26071]  = "Root",        -- Entangling Roots
  --[13022]  = "ImmuneSpell",   -- Fire and Arcane Reflect (only reflect fire and arcane spells)
  --[19595]  = "ImmuneSpell",   -- Shadow and Frost Reflect (only reflect shadow and frost spells)
  [1906]   = "Snare",       -- Debilitating Charge
  [25809]  = "Snare",       -- Crippling Poison
  [26078]  = "Snare",       -- Vekniss Catalyst
  -- -- The Prophet Skeram
  [785]    = "CC",        -- True Fulfillment
  -- -- Bug Trio: Yauj, Vem, Kri
  [3242]   = "CC",        -- Ravage
  [26580]  = "CC",        -- Fear
  [19128]  = "CC",        -- Knockdown
  [25989]  = "Snare",       -- Toxin
  -- -- Fankriss the Unyielding
  [720]    = "CC",        -- Entangle
  [731]    = "CC",        -- Entangle
  [1121]   = "CC",        -- Entangle
  -- -- Viscidus
  [25937]  = "CC",        -- Viscidus Freeze
  -- -- Princess Huhuran
  [26180]  = "CC",        -- Wyvern Sting
  [26053]  = "Silence",     -- Noxious Poison
  -- -- Twin Emperors: Vek'lor & Vek'nilash
  [800]    = "CC",        -- Twin Teleport
  [804]    = "Root",        -- Explode Bug
  [568]    = "Snare",       -- Arcane Burst
  -- -- Ouro
  [26102]  = "CC",        -- Sand Blast
  -- -- C'Thun
  [23953]  = "Snare",       -- Mind Flay
  [26211]  = "Snare",       -- Hamstring
  [26141]  = "Snare",       -- Hamstring
  ------------------------
  -- Naxxramas (Classic) Raid
  -- -- Trash
  [6605]   = "CC",        -- Terrifying Screech
  [27758]  = "CC",        -- War Stomp
  [27990]  = "CC",        -- Fear
  [28412]  = "CC",        -- Death Coil
  [29848]  = "CC",        -- Polymorph
  [29849]  = "Root",        -- Frost Nova
  [30094]  = "Root",        -- Frost Nova
  [28350]  = "Other",       -- Veil of Darkness (immune to direct healing)
  [18328]  = "Snare",       -- Incapacitating Shout
  [28310]  = "Snare",       -- Mind Flay
  [30092]  = "Snare",       -- Blast Wave
  [30095]  = "Snare",       -- Cone of Cold
  -- -- Anub'Rekhan
  [28786]  = "CC",        -- Locust Swarm
  [25821]  = "CC",        -- Charge
  [28991]  = "Root",        -- Web
  -- -- Grand Widow Faerlina
  [30225]  = "Silence",     -- Silence
  -- -- Maexxna
  [28622]  = "CC",        -- Web Wrap
  [29484]  = "CC",        -- Web Spray
  [28776]  = "Other",       -- Necrotic Poison (healing taken reduced by 90%)
  -- -- Noth the Plaguebringer
  [29212]  = "Snare",       -- Cripple
  -- -- Heigan the Unclean
  [30112]  = "CC",        -- Frenzied Dive
  [30109]  = "Snare",       -- Slime Burst
  -- -- Instructor Razuvious
  [29061]  = "Immune",      -- Bone Barrier (not immune, 75% damage reduction)
  [29125]  = "Other",       -- Hopeless (increases damage taken by 5000%)
  -- -- Gothik the Harvester
  [11428]  = "CC",        -- Knockdown
  [27993]  = "Snare",       -- Stomp
  -- -- Gluth
  [29685]  = "CC",        -- Terrifying Roar
  -- -- Sapphiron
  [28522]  = "CC",        -- Icebolt
  [28547]  = "Snare",       -- Chill
  -- -- Kel'Thuzad
  [28410]  = "CC",        -- Chains of Kel'Thuzad
  [27808]  = "CC",        -- Frost Blast
  [28478]  = "Snare",       -- Frostbolt
  [28479]  = "Snare",       -- Frostbolt
  ------------------------
  -- Classic World Bosses
  -- -- Azuregos
  [23186]  = "CC",        -- Aura of Frost
  [243901] = "CC",        -- Mark of Frost
  [21099]  = "CC",        -- Frost Breath
  [22067]  = "ImmuneSpell",   -- Reflection
  [27564]  = "ImmuneSpell",   -- Reflection
  [243835] = "ImmuneSpell",   -- Reflection
  [21098]  = "Snare",       -- Chill
  -- -- Doom Lord Kazzak & Highlord Kruul
  [8078]   = "Snare",       -- Thunderclap
  [23931]  = "Snare",       -- Thunderclap
  -- -- Dragons of Nightmare
  [25043]  = "CC",        -- Aura of Nature
  [24778]  = "CC",        -- Sleep (Dream Fog)
  [24811]  = "CC",        -- Draw Spirit
  [25806]  = "CC",        -- Creature of Nightmare
  [12528]  = "Silence",     -- Silence
  [23207]  = "Silence",     -- Silence
  [29943]  = "Silence",     -- Silence
  ------------------------
  -- Classic Dungeons
  -- -- Ragefire Chasm
  [8242]   = "CC",        -- Shield Slam
  -- -- The Deadmines
  [6304]   = "CC",        -- Rhahk'Zor Slam
  [6713]   = "Disarm",      -- Disarm
  [7399]   = "CC",        -- Terrify
  [5213]   = "Snare",       -- Molten Metal
  [6435]   = "CC",        -- Smite Slam
  [6432]   = "CC",        -- Smite Stomp
  [6264]   = "Other",       -- Nimble Reflexes (chance to parry increased by 75%)
  [113]    = "Root",        -- Chains of Ice
  [5159]   = "Snare",       -- Melt Ore
  [228]    = "CC",        -- Polymorph: Chicken
  [6466]   = "CC",        -- Axe Toss
  [92614]  = "Immune",      -- Deflection
  [88348]  = "CC",        -- Off-line
  [91732]  = "CC",        -- Off-line
  [92100]  = "CC",        -- Noxious Concoction
  [88836]  = "CC",        -- Go For the Throat
  [87901]  = "Snare",       -- Fists of Frost
  [88177]  = "Snare",       -- Frost Blossom
  [88288]  = "CC",        -- Charge
  [91726]  = "CC",        -- Reaper Charge
  [90958]  = "Other",       -- Evasion
  [95491]  = "CC",        -- Cannonball
  [135337] = "CC",        -- Cannonball
  [89769]  = "CC",        -- Explode
  [55041]  = "CC",        -- Freezing Trap Effect
  -- -- Wailing Caverns
  [8040]   = "CC",        -- Druid's Slumber
  [8147]   = "Snare",       -- Thunderclap
  [8142]   = "Root",        -- Grasping Vines
  [5164]   = "CC",        -- Knockdown
  [7967]   = "CC",        -- Naralex's Nightmare
  [8150]   = "CC",        -- Thundercrack
  -- -- Shadowfang Keep
  [7295]   = "Root",        -- Soul Drain
  [7139]   = "CC",        -- Fel Stomp
  [13005]  = "CC",        -- Hammer of Justice
  [9080]   = "Snare",       -- Hamstring
  [7621]   = "CC",        -- Arugal's Curse
  [7068]   = "Other",       -- Veil of Shadow
  [23224]  = "Other",       -- Veil of Shadow
  [28440]  = "Other",       -- Veil of Shadow
  [7803]   = "CC",        -- Thundershock
  [7074]   = "Silence",     -- Screams of the Past
  [93956]  = "Other",       -- Cursed Veil  
  [67781]  = "Snare",       -- Desecration
  [93691]  = "Snare",       -- Desecration
  [196178] = "Snare",       -- Desecration
  [93697]  = "Snare",       -- Conjure Poisonous Mixture
  [91220]  = "CC",        -- Cowering Roar
  [93423]  = "CC",        -- Asphyxiate
  [30615]  = "CC",        -- Fear
  [15497]  = "Snare",       -- Frostbolt
  [93930]  = "CC",        -- Spectral Ravaging
  [93863]  = "Root",        -- Soul Drain
  [29321]  = "CC",        -- Fear
  -- -- Blackfathom Deeps
  [246]    = "Snare",       -- Slow
  [15531]  = "Root",        -- Frost Nova
  [6533]   = "Root",        -- Net
  [8399]   = "CC",        -- Sleep
  [8379]   = "Disarm",      -- Disarm
  [18972]  = "Snare",       -- Slow
  [9672]   = "Snare",       -- Frostbolt
  [8398]   = "Snare",       -- Frostbolt Volley
  [8391]   = "CC",        -- Ravage
  [7645]   = "CC",        -- Dominate Mind
  [15043]  = "Snare",       -- Frostbolt
  [151963] = "CC",        -- Crush
  [150660] = "CC",        -- Crush
  [152417] = "CC",        -- Crush
  [149955] = "CC",        -- Devouring Blackness
  [150634] = "CC",        -- Leviathan's Grip
  [5424]   = "Root",        -- Claw Grasp
  [149910] = "Root",        -- Catch of the Day
  [302956] = "Root",        -- Catch of the Day
  -- -- The Stockade
  [3419]   = "Other",       -- Improved Blocking
  [6253]   = "CC",        -- Backhand
  [204735] = "Snare",       -- Frostbolt
  [86740]  = "CC",        -- Dirty Blow
  [86814]  = "CC",        -- Bash Head
  -- -- Gnomeregan
  [10831]  = "ImmuneSpell",   -- Reflection Field
  [11820]  = "Root",        -- Electrified Net
  [10852]  = "Root",        -- Battle Net
  [10734]  = "Snare",       -- Hail Storm
  [11264]  = "Root",        -- Ice Blast
  [10730]  = "CC",        -- Pacify
  [74720]  = "CC",        -- Pound
  -- -- Razorfen Kraul
  [8281]   = "Silence",     -- Sonic Burst
  [39052]  = "Silence",     -- Sonic Burst
  [8359]   = "CC",        -- Left for Dead
  [8285]   = "CC",        -- Rampage
  [8361]   = "Immune",      -- Purity
  [6984]   = "Snare",       -- Frost Shot
  [18802]  = "Snare",       -- Frost Shot
  [6728]   = "CC",        -- Enveloping Winds
  [3248]   = "Other",       -- Improved Blocking
  [151583] = "Root",        -- Elemental Binding
  [286963] = "CC",        -- Elemental Binding
  [153550] = "Silence",     -- Solarshard Beam
  [150357] = "Silence",     -- Solarshard Beam
  [150859] = "Snare",       -- Wing Clip
  [153214] = "CC",        -- Sonic Charge
  [150651] = "Root",        -- Vine Line
  [150304] = "Root",        -- Vine Line
  -- -- Scarlet Monastery
  [9438]   = "Immune",      -- Arcane Bubble
  [13323]  = "CC",        -- Polymorph
  [8988]   = "Silence",     -- Silence
  [8989]   = "ImmuneSpell",   -- Whirlwind
  [13874]  = "Immune",      -- Divine Shield
  [9256]   = "CC",        -- Deep Sleep
  [3639]   = "Other",       -- Improved Blocking
  [6146]   = "Snare",       -- Slow
  -- -- Razorfen Downs
  [12252]  = "Root",        -- Web Spray
  [15530]  = "Snare",       -- Frostbolt
  [12946]  = "Silence",     -- Putrid Stench
  [11443]  = "Snare",       -- Cripple
  [11436]  = "Snare",       -- Slow
  [12531]  = "Snare",       -- Chilling Touch
  [12748]  = "Root",        -- Frost Nova
  [152773] = "CC",        -- Possession
  [150082] = "Snare",       -- Plagued Bite
  [150707] = "CC",        -- Overwhelmed
  [150485] = "Root",        -- Web Wrap
  -- -- Uldaman
  [11876]  = "CC",        -- War Stomp
  [3636]   = "CC",        -- Crystalline Slumber
  [9906]   = "ImmuneSpell",   -- Reflection
  [10093]  = "Snare",       -- Harsh Winds
  [25161]  = "Silence",     -- Harsh Winds
  [55142]  = "CC",        -- Ground Tremor
  -- -- Maraudon
  [12747]  = "Root",        -- Entangling Roots
  [21331]  = "Root",        -- Entangling Roots
  [21793]  = "Snare",       -- Twisted Tranquility
  [21808]  = "CC",        -- Landslide
  [29419]  = "CC",        -- Flash Bomb
  [22592]  = "CC",        -- Knockdown
  [21869]  = "CC",        -- Repulsive Gaze
  [16790]  = "CC",        -- Knockdown
  [11922]  = "Root",        -- Entangling Roots
  -- -- Zul'Farrak
  [11020]  = "CC",        -- Petrify
  [13704]  = "CC",        -- Psychic Scream
  [11089]  = "ImmunePhysical",  -- Theka Transform (also immune to shadow damage)
  [12551]  = "Snare",       -- Frost Shot
  [11836]  = "CC",        -- Freeze Solid
  [11131]  = "Snare",       -- Icicle
  [11641]  = "CC",        -- Hex
  -- -- The Temple of Atal'Hakkar (Sunken Temple)
  [12888]  = "CC",        -- Cause Insanity
  [12480]  = "CC",        -- Hex of Jammal'an
  [12890]  = "CC",        -- Deep Slumber
  [6607]   = "CC",        -- Lash
  [25774]  = "CC",        -- Mind Shatter
  [33126]  = "Disarm",      -- Dropped Weapon
  [34259]  = "CC",        -- Fear
  -- -- Blackrock Depths
  [8994]   = "CC",        -- Banish
  [15588]  = "Snare",       -- Thunderclap
  [12674]  = "Root",        -- Frost Nova
  [12675]  = "Snare",       -- Frostbolt
  [15244]  = "Snare",       -- Cone of Cold
  [15636]  = "ImmuneSpell",   -- Avatar of Flame
  [7121]   = "ImmuneSpell",   -- Anti-Magic Shield
  [15471]  = "Silence",     -- Enveloping Web
  [3609]   = "CC",        -- Paralyzing Poison
  [15474]  = "Root",        -- Web Explosion
  [17492]  = "CC",        -- Hand of Thaurissan
  [12169]  = "Other",       -- Shield Block
  [15062]  = "Immune",      -- Shield Wall (not immune, 75% damage reduction)
  [14030]  = "Root",        -- Hooked Net
  [14870]  = "CC",        -- Drunken Stupor
  [13902]  = "CC",        -- Fist of Ragnaros
  [15063]  = "Root",        -- Frost Nova
  [6945]   = "CC",        -- Chest Pains
  [3551]   = "CC",        -- Skull Crack
  [15621]  = "CC",        -- Skull Crack
  [11831]  = "Root",        -- Frost Nova
  [15499]  = "Snare",       -- Frost Shock
  [280494] = "CC",        -- Conflagration
  [47442]  = "CC",        -- Barreled!
  [21401]  = "Snare",       -- Frost Shock
  -- -- Blackrock Spire
  [16097]  = "CC",        -- Hex
  [22566]  = "CC",        -- Hex
  [15618]  = "CC",        -- Snap Kick
  [16075]  = "CC",        -- Throw Axe
  [16045]  = "CC",        -- Encage
  [16104]  = "CC",        -- Crystallize
  [16508]  = "CC",        -- Intimidating Roar
  [15609]  = "Root",        -- Hooked Net
  [16497]  = "CC",        -- Stun Bomb
  [5276]   = "CC",        -- Freeze
  [18763]  = "CC",        -- Freeze
  [16805]  = "CC",        -- Conflagration
  [13579]  = "CC",        -- Gouge
  [24698]  = "CC",        -- Gouge
  [28456]  = "CC",        -- Gouge
  [16046]  = "Snare",       -- Blast Wave
  [15744]  = "Snare",       -- Blast Wave
  [16249]  = "Snare",       -- Frostbolt
  [16469]  = "Root",        -- Web Explosion
  [15532]  = "Root",        -- Frost Nova
  -- -- Stratholme
  [17405]  = "CC",        -- Domination
  [17246]  = "CC",        -- Possessed
  [15655]  = "CC",        -- Shield Slam
  [19645]  = "ImmuneSpell",   -- Anti-Magic Shield
  [16799]  = "Snare",       -- Frostbolt
  [16798]  = "CC",        -- Enchanting Lullaby
  [12542]  = "CC",        -- Fear
  [12734]  = "CC",        -- Ground Smash
  [17293]  = "CC",        -- Burning Winds
  [4962]   = "Root",        -- Encasing Webs
  [13322]  = "Snare",       -- Frostbolt
  [15089]  = "Snare",       -- Frost Shock
  [12557]  = "Snare",       -- Cone of Cold
  [16869]  = "CC",        -- Ice Tomb
  [17244]  = "CC",        -- Possess
  [17307]  = "CC",        -- Knockout
  [15970]  = "CC",        -- Sleep
  [3589]   = "Silence",     -- Deafening Screech
  [54791]  = "Snare",       -- Frostbolt
  [66290]  = "CC",        -- Sleep
  [82107]  = "CC",        -- Deep Freeze
  -- -- Dire Maul
  [17145]  = "Snare",       -- Blast Wave
  [22651]  = "CC",        -- Sacrifice
  [22419]  = "Disarm",      -- Riptide
  [22691]  = "Disarm",      -- Disarm
  [22833]  = "CC",        -- Booze Spit (chance to hit reduced by 75%)
  [22856]  = "CC",        -- Ice Lock
  [16727]  = "CC",        -- War Stomp
  --[22735]  = "ImmuneSpell",   -- Spirit of Runn Tum (not immune, 50% chance reflect spells)
  [22994]  = "Root",        -- Entangle
  [22924]  = "Root",        -- Grasping Vines
  [22914]  = "Snare",       -- Concussive Shot
  [22915]  = "CC",        -- Improved Concussive Shot
  [22919]  = "Snare",       -- Mind Flay
  [22909]  = "Snare",       -- Eye of Immol'thar
  [28858]  = "Root",        -- Entangling Roots
  [22415]  = "Root",        -- Entangling Roots
  [22744]  = "Root",        -- Chains of Ice
  [12611]  = "Snare",       -- Cone of Cold
  [16838]  = "Silence",     -- Banshee Shriek
  [22519]  = "CC",        -- Ice Nova
  [57825]  = "Snare",       -- Frostbolt
  -- -- Scholomance
  [5708]   = "CC",        -- Swoop
  [18144]  = "CC",        -- Swoop
  [18103]  = "CC",        -- Backhand
  [8140]   = "Other",       -- Befuddlement
  [8611]   = "Immune",      -- Phase Shift
  [17651]  = "Immune",      -- Image Projection
  [27565]  = "CC",        -- Banish
  [18099]  = "Snare",       -- Chill Nova
  [16350]  = "CC",        -- Freeze
  [17165]  = "Snare",       -- Mind Flay
  [22643]  = "Snare",       -- Frostbolt Volley
  [18101]  = "Snare",       -- Chilled (Frost Armor)
}

ns.getControlSpellType = function ( key )
  return controlSpellTypes[ key ] or ""
end
