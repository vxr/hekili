-- RogueOutlaw.lua
-- June 2018
-- Contributed by Alkena.

local addon, ns = ...
local Hekili = _G[ addon ] 

local class = Hekili.Class
local state =  Hekili.State

local PTR = ns.PTR


-- Conduits
-- [-] ambidexterity
-- [-] count_the_odds
-- [-] sleight_of_hand
-- [-] triple_threat


if UnitClassBase( "player" ) == "ROGUE" then
    local spec = Hekili:NewSpecialization( 260 )

    spec:RegisterResource( Enum.PowerType.ComboPoints )
    spec:RegisterResource( Enum.PowerType.Energy, {
        blade_rush = {
            aura = "blade_rush",

            last = function ()
                local app = state.buff.blade_rush.applied
                local t = state.query_time

                return app + floor( t - app )
            end,

            interval = 1,
            value = 5,
        }, 
    } )

    -- Talents
    spec:RegisterTalents( {
        weaponmaster = 22118, -- 200733
        quick_draw = 22119, -- 196938
        ghostly_strike = 22120, -- 196937

        acrobatic_strikes = 23470, -- 196924
        retractable_hook = 19237, -- 256188
        hit_and_run = 19238, -- 196922

        vigor = 19239, -- 14983
        deeper_stratagem = 19240, -- 193531
        marked_for_death = 19241, -- 137619

        iron_stomach = 22121, -- 193546
        cheat_death = 22122, -- 31230
        elusiveness = 22123, -- 79008

        dirty_tricks = 23077, -- 108216
        blinding_powder = 22114, -- 256165
        prey_on_the_weak = 22115, -- 131511

        loaded_dice = 21990, -- 256170
        alacrity = 23128, -- 193539
        dreadblades = 19250, -- 343142

        dancing_steel = 22125, -- 272026
        blade_rush = 23075, -- 271877
        killing_spree = 23175, -- 51690
    } )

    -- PvP Talents
    spec:RegisterPvpTalents( { 
        boarding_party = 853, -- 209752
        cheap_tricks = 142, -- 212035
        control_is_king = 138, -- 212217
        death_from_above = 3619, -- 269513
        dismantle = 145, -- 207777
        drink_up_me_hearties = 139, -- 212210
        honor_among_thieves = 3451, -- 198032
        maneuverability = 129, -- 197000
        plunder_armor = 150, -- 198529
        shiv = 3449, -- 248744
        smoke_bomb = 3483, -- 212182
        take_your_cut = 135, -- 198265
        thick_as_thieves = 1208, -- 221622
        turn_the_tables = 3421, -- 198020
    } )


    local rtb_buff_list = {
        "broadside", "buried_treasure", "grand_melee", "ruthless_precision", "skull_and_crossbones", "true_bearing", "rtb_buff_1", "rtb_buff_2"
    }


    -- Auras
    spec:RegisterAuras( {
        adrenaline_rush = {
            id = 13750,
            duration = 20,
            max_stack = 1,
        },
        alacrity = {
            id = 193538,
            duration = 20,
            max_stack = 5,
        },
        between_the_eyes = {
            id = 315341,
            duration = 15,
            max_stack = 1,
        },
        blade_flurry = {
            id = 13877,
            duration = function () return talent.dancing_steel.enabled and 15 or 12 end,
            max_stack = 1,
        },
        blade_rush = {
            id = 271896,
            duration = 5,
            max_stack = 1,
        },
        blind = {
            id = 2094,
            duration = 60,
            max_stack = 1,
        },
        cheap_shot = {
            id = 1833,
            duration = 4,
            max_stack = 1,
        },
        cloak_of_shadows = {
            id = 31224,
            duration = 5,
            max_stack = 1,
        },
        combat_potency = {
            id = 61329,
        },
        crimson_vial = {
            id = 185311,
            duration = 4,
            max_stack = 1,
        },
        crippling_poison = {
            id = 3408,
            duration = 3600,
            max_stack = 1,
        },
        detection = {
            id = 56814,
            duration = 30,
            max_stack = 1,
        },
        dreadblades = {
            id = 343142,
            duration = 10,
            max_stack = 1,
        },
        evasion = {
            id = 5277,
            duration = 10.001,
            max_stack = 1,
        },
        feint = {
            id = 1966,
            duration = 5,
            max_stack = 1,
        },
        fleet_footed = {
            id = 31209,
        },
        ghostly_strike = {
            id = 196937,
            duration = 10,
            max_stack = 1,
        },
        gouge = {
            id = 1776,
            duration = 4,
            max_stack = 1,
        },
        instant_poison = {
            id = 315584,
            duration = 3600,
            max_stack = 1,
        },
        kidney_shot = {
            id = 408,
            duration = 6,
            max_stack = 1,
        },
        killing_spree = {
            id = 51690,
            duration = 2,
            max_stack = 1,
        },
        loaded_dice = {
            id = 256171,
            duration = 45,
            max_stack = 1,
        },
        marked_for_death = {
            id = 137619,
            duration = 60,
            max_stack = 1,
        },
        numbing_poison = {
            id = 5761,
            duration = 3600,
            max_stack = 1,
        },
        opportunity = {
            id = 195627,
            duration = 10,
            max_stack = 1,
        },
        pistol_shot = {
            id = 185763,
            duration = 6,
            max_stack = 1,
        },
        prey_on_the_weak = {
            id = 255909,
            duration = 6,
            max_stack = 1,
        },
        restless_blades = {
            id = 79096,
        },
        riposte = {
            id = 199754,
            duration = 10,
            max_stack = 1,
        },
        -- Replaced this with "alias" for any of the other applied buffs.
        -- roll_the_bones = { id = 193316, },
        ruthlessness = {
            id = 14161,
        },
        sharpened_sabers = {
            id = 252285,
            duration = 15,
            max_stack = 2,
        },
        shroud_of_concealment = {
            id = 114018,
            duration = 15,
            max_stack = 1,
        },
        slice_and_dice = {
            id = 315496,
            duration = function () return talent.deeper_stratagem.enabled and 42 or 36 end,
            max_stack = 1,
        },
        sprint = {
            id = 2983,
            duration = 8,
            max_stack = 1,
        },
        stealth = {
            id = 1784,
            duration = 3600,
        },
        vanish = {
            id = 11327,
            duration = 3,
            max_stack = 1,
        },
        wound_poison = {
            id = 8679,
            duration = 3600,
            max_stack = 1
        },

        -- Real RtB buffs.
        broadside = {
            id = 193356,
            duration = 30,
        },
        buried_treasure = {
            id = 199600,
            duration = 30,
        },
        grand_melee = {
            id = 193358,
            duration = 30,
        },
        skull_and_crossbones = {
            id = 199603,
            duration = 30,
        },        
        true_bearing = {
            id = 193359,
            duration = 30,
        },
        ruthless_precision = {
            id = 193357,
            duration = 30,
        },


        -- Fake buffs for forecasting.
        rtb_buff_1 = {
            duration = 30,
        },

        rtb_buff_2 = {
            duration = 30,
        },

        roll_the_bones = {
            alias = rtb_buff_list,
            aliasMode = "first", -- use duration info from the first buff that's up, as they should all be equal.
            aliasType = "buff",
            duration = 30,
        },


        lethal_poison = {
            alias = { "instant_poison", "wound_poison", "slaughter_poison" },
            aliasMode = "first",
            aliasType = "buff",
            duration = 3600
        },
        nonlethal_poison = {
            alias = { "crippling_poison", "numbing_poison" },
            aliasMode = "first",
            aliasType = "buff",
            duration = 3600
        },


        -- Azerite Powers
        brigands_blitz = {
            id = 277725,
            duration = 20,
            max_stack = 10,
        },
        deadshot = {
            id = 272940,
            duration = 3600,
            max_stack = 1,
        },
        keep_your_wits_about_you = {
            id = 288988,
            duration = 15,
            max_stack = 30,
        },
        paradise_lost = {
            id = 278962,
            duration = 3600,
            max_stack = 1,
        },
        snake_eyes = {
            id = 275863,
            duration = 12,
            max_stack = 5,
        },
        storm_of_steel = {
            id = 273455,
            duration = 3600,
            max_stack = 1,
        },


        -- Legendaries (Shadowlands)
        concealed_blunderbuss = {
            id = 340587,
            duration = 8,
            max_stack = 1
        },

        greenskins_wickers = {
            id = 340573,
            duration = 15,
            max_stack = 1
        },

        -- Guile Charm
        shallow_insight = {
            id = 340582,
            duration = 10,
            max_stack = 1,
        },
        moderate_insight = {
            id = 340583,
            duration = 10,
            max_stack = 1,
        },
        deep_insight = {
            id = 340584,
            duration = 10,
            max_stack = 1,
        },
    } )


    spec:RegisterStateExpr( "rtb_buffs", function ()
        return buff.roll_the_bones.count
    end )


    spec:RegisterStateExpr( "cp_max_spend", function ()
        return combo_points.max
    end )


    local stealth = {
        rogue   = { "stealth", "vanish", "shadow_dance" },
        mantle  = { "stealth", "vanish" },
        all     = { "stealth", "vanish", "shadow_dance", "shadowmeld" }
    }


    spec:RegisterStateTable( "stealthed", setmetatable( {}, {
        __index = function( t, k )
            if k == "rogue" then
                return buff.stealth.up or buff.vanish.up or buff.shadow_dance.up or buff.subterfuge.up or buff.sepsis_buff.up
            elseif k == "rogue_remains" then
                return max( buff.stealth.remains, buff.vanish.remains, buff.shadow_dance.remains, buff.subterfuge.remains, buff.sepsis_buff.remains )

            elseif k == "mantle" then
                return buff.stealth.up or buff.vanish.up
            elseif k == "mantle_remains" then
                return max( buff.stealth.remains, buff.vanish.remains )
            
            elseif k == "all" then
                return buff.stealth.up or buff.vanish.up or buff.shadow_dance.up or buff.subterfuge.up or buff.shadowmeld.up or buff.sepsis_buff.up
            elseif k == "remains" or k == "all_remains" then
                return max( buff.stealth.remains, buff.vanish.remains, buff.shadow_dance.remains, buff.subterfuge.remains, buff.shadowmeld.remains, buff.sepsis_buff.remains )
            end

            return false
        end
    } ) )


    -- Legendary from Legion, shows up in APL still.
    spec:RegisterGear( "mantle_of_the_master_assassin", 144236 )
    spec:RegisterAura( "master_assassins_initiative", {
        id = 235027,
        duration = 3600
    } )

    spec:RegisterStateExpr( "mantle_duration", function ()
        return 0
    end )


    -- We need to break stealth when we start combat from an ability.
    spec:RegisterHook( "runHandler", function( ability )
        local a = class.abilities[ ability ]

        if stealthed.all and ( not a or a.startsCombat ) then
            if buff.stealth.up then
                setCooldown( "stealth", 2 )
            end

            removeBuff( "stealth" )
            removeBuff( "shadowmeld" )
            removeBuff( "vanish" )
        end
    end )


    spec:RegisterHook( "spend", function( amt, resource )
        if resource == "combo_points" then
            if amt >= 5 then gain( 1, "combo_points" ) end

            local cdr = amt * ( buff.true_bearing.up and 2 or 1 )

            reduceCooldown( "adrenaline_rush", cdr )
            reduceCooldown( "between_the_eyes", cdr )
            reduceCooldown( "blade_flurry", cdr )
            reduceCooldown( "grappling_hook", cdr )
            reduceCooldown( "roll_the_bones", cdr )
            reduceCooldown( "sprint", cdr )
            reduceCooldown( "blade_rush", cdr )
            reduceCooldown( "killing_spree", cdr )
            reduceCooldown( "vanish", cdr )
        end
    end )

    spec:RegisterHook( "reset_precast", function( amt, resource )
        if buff.killing_spree.up then setCooldown( "global_cooldown", max( gcd.remains, buff.killing_spree.remains ) ) end
    end )

    spec:RegisterCycle( function ()
        if active_enemies == 1 then return end
        if this_action == "marked_for_death" and target.time_to_die > Hekili:GetLowestTTD() then return "cycle" end
    end )


    -- Abilities
    spec:RegisterAbilities( {
        adrenaline_rush = {
            id = 13750,
            cast = 0,
            cooldown = function () return ( essence.vision_of_perfection.enabled and 0.87 or 1 ) * 180 end,
            gcd = "off",

            startsCombat = false,
            texture = 136206,

            toggle = "cooldowns",
            nobuff = "stealth",

            handler = function ()
                applyBuff( "adrenaline_rush", 20 )

                energy.regen = energy.regen * 1.6
                energy.max = energy.max + 50

                forecastResources( "energy" )

                if talent.loaded_dice.enabled then
                    applyBuff( "loaded_dice", 45 )
                elseif azerite.brigands_blitz.enabled then
                    applyBuff( "brigands_blitz" )
                end
            end,
        },


        ambush = {
            id = 8676,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = 50,
            spendType = "energy",

            startsCombat = true,
            texture = 132282,

            usable = function () return stealthed.all or buff.sepsis_buff.up, "requires stealth or sepsis_buff" end,
            handler = function ()
                if debuff.dreadblades.up then
                    gain( combo_points.max, "combo_points" )
                else
                    gain( buff.broadside.up and 3 or 2, "combo_points" )
                end

                removeBuff( "sepsis_buff" )
            end,
        },


        between_the_eyes = {
            id = 315341,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = 25,
            spendType = "energy",

            startsCombat = true,
            texture = 135610,

            usable = function() return combo_points.current > 0 end,

            handler = function ()
                if talent.prey_on_the_weak.enabled then
                    applyDebuff( "target", "prey_on_the_weak", 6 )
                end

                if talent.alacrity.enabled and combo_points.current > 4 then
                    addStack( "alacrity", 20, 1 )
                end

                applyDebuff( "target", "between_the_eyes", combo_points.current ) 

                if azerite.deadshot.enabled then
                    applyBuff( "deadshot" )
                end

                if combo_points.current == animacharged_cp then removeBuff( "echoing_reprimand" ) end

                if legendary.greenskins_wickers.enabled and ( combo_points.current >= 5 or combo_points == animacharged_cp ) then
                    applyBuff( "greenskins_wickers" )
                end

                spend( min( talent.deeper_stratagem.enabled and 6 or 5, combo_points.current ), "combo_points" ) 
            end,
        },


        blade_flurry = {
            id = 13877,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = 15,
            spendType = "energy",

            startsCombat = false,
            texture = 132350,

            usable = function () return buff.blade_flurry.remains < gcd.execute end,
            handler = function ()
                applyBuff( "blade_flurry" )
            end,
        },


        blade_rush = {
            id = 271877,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            startsCombat = true,
            texture = 1016243,

            handler = function ()
                applyBuff( "blade_rush", 5 )
            end,
        },


        blind = {
            id = 2094,
            cast = 0,
            cooldown = function () return talent.blinding_powder.enabled and 90 or 120 end,
            gcd = "spell",

            startsCombat = true,
            texture = 136175,

            handler = function ()
              applyDebuff( "target", "blind", 60 )
            end,
        },


        cheap_shot = {
            id = 1833,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function () return ( talent.dirty_tricks.enabled and 0 or 40 ) * ( 1 - conduit.rushed_setup.mod * 0.01 ) end,
            spendType = "energy",

            startsCombat = true,
            texture = 132092,

            cycle = function ()
                if talent.prey_on_the_weak.enabled then return "prey_on_the_weak" end
            end,

            usable = function ()
                if boss then return false, "cheap_shot assumed unusable in boss fights" end
                return stealthed.all or buff.subterfuge.up, "not stealthed"
            end,

            handler = function ()
                applyDebuff( "target", "cheap_shot", 4 )

                if talent.prey_on_the_weak.enabled then
                    applyDebuff( "target", "prey_on_the_weak", 6 )
                end
            end,
        },


        cloak_of_shadows = {
            id = 31224,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = false,
            texture = 136177,

            handler = function ()
                applyBuff( "cloak_of_shadows", 5 )
            end,
        },


        crimson_vial = {
            id = 185311,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = function () return 20 - conduit.nimble_fingers.mod end,
            spendType = "energy",

            startsCombat = false,
            texture = 1373904,

            handler = function ()
                applyBuff( "crimson_vial", 6 )
            end,
        },


        crippling_poison = {
            id = 3408,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            essential = true,
            
            startsCombat = false,
            texture = 132274,
            
            readyTime = function () return buff.nonlethal_poison.remains - 120 end,

            handler = function ()
                applyBuff( "crippling_poison" )
            end,
        },


        dispatch = {
            id = 2098,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = 35,
            spendType = "energy",

            startsCombat = true,
            texture = 236286,

            usable = function() return combo_points.current > 0 end,
            handler = function ()
                if talent.alacrity.enabled and combo_points.current > 4 then
                    addStack( "alacrity", 20, 1 )
                end

                removeBuff( "storm_of_steel" )

                if combo_points.current == animacharged_cp then removeBuff( "echoing_reprimand" ) end
                spend( min( talent.deeper_stratagem.enabled and 6 or 5, combo_points.current ), "combo_points" )
            end,
        },


        distract = {
            id = 1725,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            spend = function () return 30 * ( 1 - conduit.rushed_setup.mod * 0.01 ) end,
            spendType = "energy",

            startsCombat = false,
            texture = 132289,

            handler = function ()
            end,
        },


        dreadblades = {
            id = 343142,
            cast = 0,
            cooldown = 90,
            gcd = "spell",
            
            spend = 30,
            spendType = "energy",

            toggle = "cooldowns",
            talent = "dreadblades",

            startsCombat = true,
            texture = 458731,
            
            handler = function ()
                applyDebuff( "player", "dreadblades" )
                gain( buff.broadside.up and 2 or 1, "combo_points" )
            end,
        },


        evasion = {
            id = 5277,
            cast = 0,
            cooldown = 120,
            gcd = "spell",
            
            toggle = "defensives",

            startsCombat = true,
            texture = 136205,
            
            handler = function ()
                applyBuff( "evasion" )
            end,
        },


        feint = {
            id = 1966,
            cast = 0,
            cooldown = 15,
            gcd = "spell",

            spend = function () return 35 - conduit.nimble_fingers.mod end,
            spendType = "energy",

            startsCombat = false,
            texture = 132294,

            handler = function ()
                applyBuff( "feint", 5 )
            end,
        },


        ghostly_strike = {
            id = 196937,
            cast = 0,
            cooldown = 35,
            gcd = "spell",

            spend = 30,
            spendType = "energy",

            talent = "ghostly_strike",

            startsCombat = true,
            texture = 132094,

            handler = function ()
                applyDebuff( "target", "ghostly_strike", 10 )
                gain( buff.broadside.up and 2 or 1, "combo_points" )
            end,
        },


        gouge = {
            id = 1776,
            cast = 0,
            cooldown = 15,
            gcd = "spell",

            spend = function () return talent.dirty_tricks.enabled and 0 or 25 end,
            spendType = "energy",

            startsCombat = true,
            texture = 132155,

            usable = function () return talent.dirty_tricks.enabled and settings.dirty_gouge, "requires dirty_tricks and dirty_gouge checked" end,

            handler = function ()
                gain( buff.broadside.up and 2 or 1, "combo_points" )
                applyDebuff( "target", "gouge", 4 )
            end,
        },


        grappling_hook = {
            id = 195457,
            cast = 0,
            cooldown = function () return ( 1 - conduit.quick_decisions.mod * 0.01 ) * ( talent.retractable_hook.enabled and 45 or 60 ) - ( level > 55 and 15 or 0 ) end,
            gcd = "spell",

            startsCombat = false,
            texture = 1373906,

            handler = function ()
            end,
        },


        instant_poison = {
            id = 315584,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            essential = true,
            
            startsCombat = false,
            texture = 132273,
            
            readyTime = function () return buff.lethal_poison.remains - 120 end,

            handler = function ()
                applyBuff( "instant_poison" )
            end,
        },


        kick = {
            id = 1766,
            cast = 0,
            cooldown = 15,
            gcd = "spell",

            toggle = "interrupts", 
            interrupt = true,

            startsCombat = true,
            texture = 132219,

            debuff = "casting",
            readyTime = state.timeToInterrupt,

            handler = function ()
                interrupt()
                
                if conduit.prepared_for_all.enabled and cooldown.cloak_of_shadows.remains > 0 then
                    reduceCooldown( "cloak_of_shadows", 2 * conduit.prepared_for_all.mod )
                end
            end,
        },


        kidney_shot = {
            id = 408,
            cast = 0,
            cooldown = 20,
            gcd = "spell",
            
            spend = function () return 25 * ( 1 - conduit.rushed_setup.mod * 0.01 ) end,
            spendType = "energy",
            
            startsCombat = true,
            texture = 132298,
            
            handler = function ()
                applyDebuff( "kidney_shot", 1 + combo_points.current )
                if combo_points.current == animacharged_cp then removeBuff( "echoing_reprimand" ) end
                spend( combo_points.current, "combo_points" )
            end,
        },


        killing_spree = {
            id = 51690,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            talent = "killing_spree",

            startsCombat = true,
            texture = 236277,

            toggle = "cooldowns",

            handler = function ()
                applyBuff( "killing_spree", 2 )
                setCooldown( "global_cooldown", 2 )
            end,
        },


        marked_for_death = {
            id = 137619,
            cast = 0,
            cooldown = 60,
            gcd = "spell",

            talent = "marked_for_death", 

            startsCombat = false,
            texture = 236364,

            usable = function ()
                return settings.mfd_waste or combo_points.current == 0, "combo_point (" .. combo_points.current .. ") waste not allowed"
            end,

            handler = function ()
                gain( 5, "combo_points" )
            end,
        },


        numbing_poison = {
            id = 5761,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            essential = true,
            
            startsCombat = false,
            texture = 136066,
            
            readyTime = function () return buff.nonlethal_poison.remains - 120 end,

            handler = function ()
                applyBuff( "numbing_poison" )
            end,
        },


        pick_lock = {
            id = 1804,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 136058,

            handler = function ()
            end,
        },


        pick_pocket = {
            id = 921,
            cast = 0,
            cooldown = 0.5,
            gcd = "spell",

            startsCombat = false,
            texture = 133644,

            handler = function ()
            end,
        },


        pistol_shot = {
            id = 185763,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function () return 40 - ( buff.opportunity.up and 20 or 0 ) end,
            spendType = "energy",

            startsCombat = true,
            texture = 1373908,

            handler = function ()
                if debuff.dreadblades.up then
                    gain( combo_points.max, "combo_points" )
                else
                    gain( 1 + ( buff.broadside.up and 1 or 0 ) + ( buff.opportunity.up and 1 or 0 ) + ( buff.concealed_blunderbuss.up and 2 or 0 ), "combo_points" )
                end

                removeBuff( "deadshot" )
                removeBuff( "opportunity" )
                removeBuff( "concealed_blunderbuss" ) -- Generating 2 extra combo points is purely a guess.
                removeBuff( "greenskins_wickers" )
            end,
        },


        riposte = {
            id = 199754,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = false,
            texture = 132269,

            handler = function ()
                applyBuff( "riposte", 10 )
            end,
        },


        roll_the_bones = {
            id = 315508,
            cast = 0,
            cooldown = 45,
            gcd = "spell",

            spend = 25,
            spendType = "energy",

            startsCombat = false,
            texture = 1373910,

            handler = function ()
                for _, name in pairs( rtb_buff_list ) do
                    removeBuff( name )
                end

                if azerite.snake_eyes.enabled then
                    applyBuff( "snake_eyes", 12, 5 )
                end

                applyBuff( "rtb_buff_1" )

                if buff.loaded_dice.up then
                    applyBuff( "rtb_buff_2"  )
                    removeBuff( "loaded_dice" )
                end
            end,
        },


        sap = {
            id = 6770,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = function () return ( talent.dirty_tricks.enabled and 0 or 35 ) * ( 1 - conduit.rushed_setup.mod * 0.01 ) end,
            spendType = "energy",

            startsCombat = false,
            texture = 132310,

            handler = function ()
                applyDebuff( "target", "sap", 60 )
            end,
        },
        

        
        shiv = {
            id = 5938,
            cast = 0,
            cooldown = 25,
            gcd = "spell",
            
            spend = function () return legendary.tiny_toxic_blade.enabled and 0 or 20 end,
            spendType = "energy",
            
            startsCombat = true,
            texture = 135428,
            
            handler = function ()
                gain( buff.broadside.up and 2 or 1, "combo_point" )
            end,
        },

        shroud_of_concealment = {
            id = 114018,
            cast = 0,
            cooldown = 360,
            gcd = "spell",

            startsCombat = false,
            texture = 635350,

            handler = function ()
                applyBuff( "shroud_of_concealment", 15 )
                if conduit.fade_to_nothing.enabled then applyBuff( "fade_to_nothing" ) end
            end,
        },


        sinister_strike = {
            id = 193315,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = 45,
            spendType = "energy",

            startsCombat = true,
            texture = 136189,

            handler = function ()
                removeStack( "snake_eyes" )
                if debuff.dreadblades.up then
                    gain( combo_points.max, "combo_points" )
                else
                    gain( buff.broadside.up and 2 or 1, "combo_points" )
                end

                if buff.shallow_insight.up then buff.shallow_insight.expires = query_time + 10 end
                if buff.moderate_insight.up then buff.moderate_insight.expires = query_time + 10 end
                -- Deep Insight does not refresh, and I don't see a way to track why/when we'd advance from Shallow > Moderate > Deep.
            end,
        },


        slice_and_dice = {
            id = 315496,
            cast = 0,
            cooldown = 0,
            gcd = "spell",

            spend = 25,
            spendType = "energy",

            startsCombat = false,
            texture = 132306,

            usable = function()
                return combo_points.current > 0, "requires combo_points"
            end,

            handler = function ()
                if talent.alacrity.enabled and combo_points.current > 4 then
                    addStack( "alacrity", 20, 1 )
                end

                local combo = min( talent.deeper_stratagem.enabled and 6 or 5, combo_points.current )
                applyBuff( "slice_and_dice", 6 + 6 * combo )
                spend( combo, "combo_points" )
            end,
        },


        sprint = {
            id = 2983,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = false,
            texture = 132307,

            handler = function ()
                applyBuff( "sprint", 8 )
            end,
        },


        stealth = {
            id = 1784,
            cast = 0,
            cooldown = 2,
            gcd = "off",

            startsCombat = false,
            texture = 132320,

            usable = function ()
                if time > 0 then return false, "cannot stealth in combat"
                elseif buff.stealth.up then return false, "already in stealth"
                elseif buff.vanish.up then return false, "already vanished" end
                return true
            end,

            handler = function ()
                applyBuff( "stealth" )

                if conduit.cloaked_in_shadows.enabled then applyBuff( "cloaked_in_shadows" ) end
                if conduit.fade_to_nothing.enabled then applyBuff( "fade_to_nothing" ) end
            end,
        },


        tricks_of_the_trade = {
            id = 57934,
            cast = 0,
            cooldown = 30,
            gcd = "spell",

            startsCombat = false,
            texture = 236283,

            handler = function ()
                applyBuff( "tricks_of_the_trade" )
            end,
        },


        vanish = {
            id = 1856,
            cast = 0,
            cooldown = 120,
            gcd = "spell",

            startsCombat = false,
            texture = 132331,

            disabled = function ()
                return not settings.solo_vanish and not ( boss and group ), "can only vanish in a boss encounter or with a group"
            end,

            handler = function ()
                applyBuff( "vanish", 3 )
                applyBuff( "stealth" )

                if conduit.cloaked_in_shadows.enabled then applyBuff( "cloaked_in_shadows" ) end
                if conduit.fade_to_nothing.enabled then applyBuff( "fade_to_nothing" ) end

                if legendary.invigorating_shadowdust.enabled then
                    for name, cd in pairs( cooldown ) do
                        if cd.remains > 0 then reduceCooldown( name, 20 ) end
                    end
                end
            end,
        },


        wound_poison = {
            id = 8679,
            cast = 1.5,
            cooldown = 0,
            gcd = "spell",

            startsCombat = false,
            texture = 134194,

            readyTime = function () return buff.lethal_poison.remains - 120 end,

            handler = function ()
                applyBuff( "wound_poison" )
            end,
        }


    } )


    -- Override this for rechecking.
    spec:RegisterAbility( "shadowmeld", {
        id = 58984,
        cast = 0,
        cooldown = 120,
        gcd = "off",

        usable = function () return boss and group end,
        handler = function ()
            applyBuff( "shadowmeld" )
        end,
    } )


    spec:RegisterOptions( {
        enabled = true,

        aoe = 3,

        nameplates = true,
        nameplateRange = 8,

        damage = true,
        damageExpiration = 6,

        potion = "phantom_fire",

        package = "Outlaw",
    } )

    spec:RegisterSetting( "mfd_waste", true, {
        name = "Allow |T236364:0|t Marked for Death Combo Waste",
        desc = "If unchecked, the addon will not recommend |T236364:0|t Marked for Death if it will waste combo points.",
        type = "toggle",
        width = "full"
    } )  

    spec:RegisterSetting( "dirty_gouge", false, {
        name = "Use |T132155:0|t Gouge with Dirty Tricks",
        desc = "If checked, the addon will recommend |T132155:0|t Gouge when Dirty Tricks is talented and you do not have " ..
            "enough energy to Sinister Strike.  |cFFFFD100This may be problematic for positioning|r, as you'd need to be in front of your " ..
            "target.\n\nThis setting is unchecked by default.",
        type = "toggle",
        width = "full",
    } )

    spec:RegisterSetting( "solo_vanish", true, {
        name = "Allow |T132331:0|t Vanish when Solo",
        desc = "If unchecked, the addon will not recommend |T132331:0|t Vanish when you are alone (to avoid resetting combat).",
        type = "toggle",
        width = "full"
    } )


    spec:RegisterPack( "Outlaw", 20201225, [[d4KDQaqiLs9ikKUefQiBcQ0NOuLrrO4ueOwLsjWRiGzriDlcLAxk5xeIHbvXXGQAza4zuOmnkvvxdQsBJqj(MsjX4ukrohfQY6GkK5bv09uQ2hLkhuPKAHa0djqAIuQkxKcv1gvkr9rkuHtcvOwjfmtLss3uPeYovk(jfQ0qjushvPe0sjq4Ps1uLsDvOc0wPqf1xHkGXsGO9QQ)kYGHCyQwSOEmPMmjxg1MHYNb0OPKtlz1kLq9AcQzt0TLIDRYVrmCk64qf0Yr65GMUW1bA7eKVtOA8uiopLY8Ls2VIF8)2Fx5b)BaapaGh8baa8UWhVgdV4dW3dBM83nDTWoq(7N3WFFRHqhcRZJICF30TjjU6B)DibKQ5VBfHjehjIiaRWcmV0KgrGvdO0JICAQJfIaRgTiFpdwYahFF(7kp4Fda4ba8GpaaG3f(41y4fpgVV7GHfH(9E1iOF3Quk((83vmu)DJoiJlyiDXhKGGaeKhdgDq2hR5Mmthea4v0bbaEaapFxwWa(T)UIXCqz8T)n4)T)URJICFx4sl835ZZsw9a(XVbGV93DDuK77WGDzy9D(8SKvpGF8Bm23(785zjREa)oX87qo(URJICFxiNwEwYFxixcYFNg5ugeddoiCoiageUdsmdA7bLbXWwbfKtz2P1bCbAoiCh02dkdIHTYuIRGLIxGMdsWFxiNMoVH)onYjktjs5h)g7)B)D(8SKvpGFNy(DihF31rrUVlKtlpl5VlKlb5VRjnzsYKuxaxkgR0vmi72headsGbLbXWwzkXvWsXlqZbH7G4JPaTni72heEXZGWDqIzqBpin5uGvS0eWlsHfNikfCXNNLSAqTAnOmig2IsKYuyXPm5y4IYnEDWbz3(GWhpdsWFxiNMoVH)U3KbHwjn5uvuK7JFdE)2FNpplz1d43jMFhYX3DDuK77c50YZs(7c5sq(7qtwktHtbYbCLLUItysqk12GW5Gayq4oiQxQeleFXYvk4QUbz3GaapdQvRbLbXWwzPR4eMeKsTTan)UqonDEd)9S0vCctcsP2sqBN(JFJy5B)D(8SKvpGFxtRGPL)DyWUmSy1YLYV76Oi33PGxY1rrUKSGX3LfmsN3WFhgSldRp(nBLV935ZZsw9a(Dxhf5(U2LYKRJICjzbJVllyKoVH)Uwb)43SL(2FNpplz1d4310kyA5FxtAYKKjPUaoi72hK2m14gjbn5tniXEqzqmSvMsCfSu8c0CqI9GeZGYGyylIPjHgGxf2wGMdAlyqHl5lw4qWslCsrDXx85zjRgKGhuRwdstAYKKjPUaoO9b5x14AlNcKvjT53DDuK77uWl56OixswW47YcgPZB4VJvxbT(43y8(2FNpplz1d43DDuK77AxktUokYLKfm(USGr68g(7zWsQ(43GpE(2FNpplz1d4310kyA5FNpMc02sXyLUIbz3(GWhVdsGbXhtbABrzG89Dxhf5(Ut1(XPGqP8fF8BWh)V93DDuK77ov7hNmbLq(785zjREa)43GpaF7V76Oi33LfqRaM2IbvaB4l(oFEwYQhWp(n4BSV93DDuK77zhyIGLcAPfg(D(8SKvpGF8X3nPSM0K94B)BW)B)Dxhf5(UBAkTLmjfKCFNpplz1d4h)ga(2F31rrUVNjrizvct62yL41bmfeJu335ZZsw9a(XVXyF7VZNNLS6b87UokY99gNkmRsyeAsXEy9DnTcMw(3PEPsSq8flxPGR6gKDdca8(DtkRjnzpsqwtof8749JFJ9)T)oFEwYQhWV76Oi33PePmfwCktog(DnTcMw(3PCJxhCq4CqgBq4oiAKtzqmm4GW5Ga47MuwtAYEKGSMCk43b4JFdE)2FNpplz1d43DDuK77qzP5KFQKQ08310kyA5FNYyugA5zj)DtkRjnzpsqwtof87a8XVrS8T)URJICFhgSldRVZNNLS6b8Jp(EgSKQV9Vb)V93DDuK77q2ewWVZNNLS6b8JFdaF7V76Oi33bArGH0wcg0sy(785zjREa)43ySV935ZZsw9a(DnTcMw(3PGhJrOa5vuNTuqmsPtzPR4fFEwYQV76Oi33HwLqF8BS)V93DDuK77S2IuhWeLnPvJFQVZNNLS6b8JFdE)2FNpplz1d43DDuK77qMs9GvPm54e0SeM)UMwbtl)7BpifjwqMs9GvPm54e0SeMxrPfUoGdQvRb56OeIt8Xnfdh0(GWFq4oiQxQeleFXYvk4QUbz3GWaLYeL1wofiNIQHhuRwdsB5uGmCq2niageUdcRaAfjk341bheoheE)U2MwYPWPa5a(BW)JFJy5B)D(8SKvpGFxtRGPL)9mig2IyAsOb4vHTfO5GWDqIzq8XuG2geohK9J3b1Q1GcxYxSWHGLw4KI6IV4ZZswnib)Dxhf5(UzbdImbTiXh)MTY3(785zjREa)UMwbtl)7zqmSfX0KqdWRcBlqZbH7GeZGYGyylGuMpOW1btIxAHzkCbAoOwTgugedBPjNMDjRszj4PyAgecxGMdsWF31rrUVBwWGitqls8XVzl9T)URJICFhwxbdMMGbTeM)oFEwYQhWp(ngVV935ZZsw9a(DnTcMw(3dxYxSufnSLcAPfgU4ZZswniChKM0KjjtsDbCPySsxXGSBFq4pibgugedBLPexblfVan)URJICFhibei)XhFxRGF7Fd(F7VZNNLS6b87AAfmT8VV9GGb7YWIvlxkheUdsiNwEwYlVjdcTsAYPQOi3GWDqnomyAYHqhcRlr5gVo4G2heEgeUdsmdA7brbpgJqbYlf7HL0wcA5kI4WfFEwYQb1Q1GYGyylf7HL0wcA5kI4WLIi(niChKM0KjjtsDbCq4CFqamib)Dxhf5(Uq(vqRp(na8T)URJICFht6azP0JICFNpplz1d4h)gJ9T)oFEwYQhWVRPvW0Y)UIZGyylmPdKLspkYTOCJxhCq4Cqa8Dxhf5(oM0bYsPhf5sAj7hK)43y)F7VZNNLS6b87AAfmT8VV9GYGyylxr5ZL1Xjki0AbAoiChKyg02dstisfr8BjCjL1bmbnPmVanhuRwdA7bfUKVyjCjL1bmbnPmV4ZZswnib)Dxhf5(URO85Y64efeA9XVbVF7VZNNLS6b87AAfmT8VNbXWwuIuMcloLjhdxuUXRdoiCUpiJnOwTgKqoT8SKx0iNOmLiLF31rrUVtjszkS4uMCm8JFJy5B)D(8SKvpGF31rrUV34uHzvcJqtk2dRVRPvW0Y)o1lvIfIVy5kfCbAoiChKygu4uGCSIQHtbjPkEq4CqAstMKmj1fWLIXkDfdQvRbT9GGb7YWIvlkbiipiChKM0KjjtsDbCPySsxXGSBFqAZuJBKe0Kp1Ge7bH)Ge83120sofofihWFd(F8B2kF7VZNNLS6b87AAfmT8Vt9sLyH4lwUsbx1ni7gKXWZGe7br9sLyH4lwUsbxkqQhf5geUdA7bbd2LHfRwucqqEq4oinPjtsMK6c4sXyLUIbz3(G0MPg3ijOjFQbj2dc)V76Oi33BCQWSkHrOjf7H1h)MT03(785zjREa)UMwbtl)7qtwktHtbYbCq2TpiageUdA7bLbXWwzPR4eMeKsTTan)URJICFplDfNWKGuQTp(ngVV935ZZsw9a(DnTcMw(3fYPLNL8klDfNWKGuQTe02PheUdsmdIpMc02kQgofKuJBKbz3GayqTAniOjlLPWPa5aoi7geadsWF31rrUVlCjL1bmbnPm)XVbF88T)oFEwYQhWVRPvW0Y)UqoT8SKxzPR4eMeKsTLG2o9GWDqIzq8XuG2wr1WPGKACJmi7geadQvRbbnzPmfofihWbz3Gayqc(7UokY99S0vCIccT(43Gp(F7VZNNLS6b87AAfmT8VV9GGb7YWIvlxkheUdstAYKKjPUaoiCUpi8)URJICFxrzxLLUIHF8BWhGV935ZZsw9a(DnTcMw(33EqWGDzyXQLlLdc3bjKtlpl5L3KbHwjn5uvuK77UokY9DOLRiI3Ws1h)g8n23(785zjREa)UMwbtl)7zqmSvwsikjimwu21XGA1AqyfqRir5gVo4GW5GmgEguRwdkdIHTCfLpxwhNOGqRfO53DDuK77MKOi3h)g8T)V93DDuK77zjHOsyGuBFNpplz1d4h)g8X73(7UokY99mtHmv46a(D(8SKvpGF8BWxS8T)URJICFhROCwsiQVZNNLS6b8JFd(BLV93DDuK77(PzyqDzs7s535ZZsw9a(XVb)T03(785zjREa)UMwbtl)7kodIHTYCioZxkS4eBJHlqZbH7GeZG2EqHl5lwaTiWqAlbdAjmV4ZZswnOwTgKIZGyylGweyiTLGbTeMxGMdsWdQvRbHvaTIeLB86GdcN7dca88Dxhf5(oiKtvWnWp(47WGDzy9T)n4)T)oFEwYQhWVRPvW0Y)UM0KjjtsDbCq2TpiTzQXnscAYN67UokY9Dvbn9qB9XVbGV93DDuK77EtgeA9D(8SKvpGF8Bm23(785zjREa)URJICFxBXUzcArIVRPvW0Y)E4s(ILjLTLixkS4K4Sl8Ipplz1GWDqBpOWPa5yvWuMaHFxBtl5u4uGCa)n4)XhFhRUcA9T)n4)T)URJICFpZH4mFPWItSng(D(8SKvpGF8Ba4B)D(8SKvpGFxtRGPL)9mig2cklnN8tLuLMxuUXRdoiCoiScOvKOCJxhCq4oikJrzOLNL83DDuK77qzP5KFQKQ08h)gJ9T)URJICFxvqtp0wFNpplz1d4hF8X3fIPWIC)gaWda4bFaW3yFxCNE1be(DCGTwqSbhVX4ahnOb12Ihu1ysOXGWi0bzpfJ5GYWEdIY4qWIYQbbjn8GCWG04bRgK2YpGmCng2Q1XdY(XrdsqjNqmny1GSNMCkWkwcs7nOGmi7PjNcSILGCXNNLSYEdsm4BebVgdJbCGTwqSbhVX4ahnOb12Ihu1ysOXGWi0bzpTcAVbrzCiyrz1GGKgEqoyqA8GvdsB5hqgUgdB164bHpoAqck5eIPbRgK9OGhJrOa5LG0EdkidYEuWJXiuG8sqU4ZZswzVbjg8nIGxJHXaoWwli2GJ3yCGJg0GABXdQAmj0yqye6GSxgSKk7nikJdblkRgeK0WdYbdsJhSAqAl)aYW1yyRwhpiJHJgKGsoHyAWQbzpk4XyekqEjiT3GcYGShf8ymcfiVeKl(8SKv2BqEmiJVXDRoiXGVre8AmmgWXnMeAWQbjwgKRJICdswWaUgdFhAY6Fda4149DtkbRK83n6GmUGH0fFqcccqqEmy0bzFSMBYmDqaGxrhea4ba8mggdgDqgFJWAWGvdkZyekpinPj7XGYmW6GRbT1AnBgWbDKtSTCAdgOCqUokYbhe5K2wJbxhf5GltkRjnzp2DttPTKjPGKBm46OihCzsznPj7Ha7IKjrizvct62yL41bmfeJu3yW1rro4YKYAst2db2fPXPcZQegHMuShwIAsznPj7rcYAYPG74v0cBN6LkXcXxSCLcUQZoaW7yW1rro4YKYAst2db2fHsKYuyXPm5yOOMuwtAYEKGSMCk4oaIwy7uUXRdItJHlnYPmiggeNamgCDuKdUmPSM0K9qGDrGYsZj)ujvPzrnPSM0K9ibzn5uWDaeTW2PmgLHwEwYJbxhf5GltkRjnzpeyxeyWUmSgdJbJoiJVrynyWQbXcXuBdkQgEqHfpixhe6Gk4GCH8s6zjVgdUokYb3fU0cpgm6GeemmyxgwdQWgKjbcRSKhKyoYGecuEm1ZsEq8XnfdhuDdstAYEi4XGRJICqb2fbgSldRXGrhKGGPePCqW6ak5bLbXWGdIDQ02GiHfthuy53GAtb5bbi706aoi)udcqkXvWsXJbxhf5GcSlIqoT8SKf98gENg5eLPePuuHCjiVtJCkdIHbXja4kMTZGyyRGcYPm706aUanXD7mig2ktjUcwkEbAk4XGrhKX)GGuEqIZdcihdcdukh0w3KbHwdsqfRdcOxhCq(PgKt5ZEXGOmLiL1bCqckb8Ibfw8GmUkfCqzqmm4GCXDBJbxhf5GcSlIqoT8SKf98gE3BYGqRKMCQkkYjQqUeK31KMmjzsQlGlfJv6kSBhabYGyyRmL4kyP4fOjU8XuG2SBhV4bxXSTMCkWkwAc4fPWIteLc2QvgedBrjszkS4uMCmCr5gVoOD74Jhbpgm6GWbQWAqnGYOmL8GcNcKdOOdkSk4GeYPLNL8Gk4G0wSwywnOGmifRlfpiXT4WIPdcsA4bjO2hCqqlcOunOmpiOTtZQbjEfwdcqPR4bTLLGuQTXGRJICqb2friNwEwYIEEdVNLUItysqk1wcA70IkKlb5DOjlLPWPa5aUYsxXjmjiLAdNaGl1lvIfIVy5kfCvNDaGNwTYGyyRS0vCctcsP2wGMJbxhf5GcSlcf8sUokYLKfme98gEhgSldlrlSDyWUmSy1YLYXGRJICqb2fr7szY1rrUKSGHON3W7AfCmy0bTLRRGwdYJb14gPAaBgKGkwhugmgKlePudsChg1bCqasjUcwkEq(Pg0wiyPfEq2h1fFqzYbchKM0KjdYKuxahdUokYbfyxek4LCDuKljlyi65n8owDf0s0cBxtAYKKjPUaA3U2m14gjbn5tj2zqmSvMsCfSu8c0uSftgedBrmnj0a8QW2c0CliCjFXchcwAHtkQl(IpplzLGB1stAYKKjPUaU7x14AlNcKvjT5yW1rroOa7IODPm56OixswWq0ZB49myjvJbxhf5GcSlIt1(XPGqP8fIwy78XuG2wkgR0vy3o(4va(ykqBlkdKVXGRJICqb2fXPA)4KjOeYJbxhf5GcSlISaAfW0wmOcydFXyW1rroOa7IKDGjcwkOLwy4yymy0bbiyjvmfogCDuKdUYGLuTdztybhdUokYbxzWsQeyxeGweyiTLGbTeMhdUokYbxzWsQeyxeOvjKOf2of8ymcfiVI6SLcIrkDklDfpgCDuKdUYGLujWUiS2IuhWeLnPvJFQXGRJICWvgSKkb2fbYuQhSkLjhNGMLWSOABAjNcNcKd4o(Iwy7BRiXcYuQhSkLjhNGMLW8kkTW1bSvlxhLqCIpUPy4o(4s9sLyH4lwUsbx1zhgOuMOS2YPa5uunCRwAlNcKH2baUyfqRir5gVoioX7yWOdcheYdsSwWGihu3Ieds8kSgKX10KqdWRcBdQWguMLeXhK9J3bXhtbAt0brOdsCl(geiSoGdAleS0cpi7J6IpgCDuKdUYGLujWUiMfmiYe0IeIwy7zqmSfX0KqdWRcBlqtCfdFmfOnCA)4TvRWL8flCiyPfoPOU4l(8SKvcEm46OihCLblPsGDrmlyqKjOfjeTW2ZGyylIPjHgGxf2wGM4kMmig2ciL5dkCDWK4LwyMcxGMTALbXWwAYPzxYQuwcEkMMbHWfOPGhdUokYbxzWsQeyxeyDfmyAcg0syEm46OihCLblPsGDrasabYIwy7Hl5lwQIg2sbT0cdx85zjRWvtAYKKjPUaUumwPRWUD8fidIHTYuIRGLIxGMJHXGrhKGsisfr8dogm6GWbH1bCqBDtgeAnOcoiFqayCAq1PPSdzrheKmiJZ(vqRbP9BqzEqqsdhvddhuMheiKvdYHdYheyuYkSniOjlLdc8KmeoiqyDah0wKddMoOTgcDiSUbrOdY(ypSK2gu3YveXHJbxhf5GlTcUlKFf0s0cBFByWUmSy1YLsCfYPLNL8YBYGqRKMCQkkYHBJddMMCi0HW6suUXRdUJhCfZ2uWJXiuG8sXEyjTLGwUIioSvRmig2sXEyjTLGwUIioCPiIF4QjnzsYKuxaX5oacEm46OihCPvqb2fbt6azP0JICJbxhf5GlTckWUiyshilLEuKlPLSFqw0cBxXzqmSfM0bYsPhf5wuUXRdItagdUokYbxAfuGDrCfLpxwhNOGqlrlS9TZGyylxr5ZL1Xjki0AbAIRy2wtisfr8BjCjL1bmbnPmVanB1A7WL8flHlPSoGjOjL5fFEwYkbpgCDuKdU0kOa7IqjszkS4uMCmu0cBpdIHTOePmfwCktogUOCJxheN7gRvlHCA5zjVOrorzkrkhdgDq4ySb5kfCqoLheOPOdcELjpOWIhe54bjEfwdsseNHXGA32(wdcheYdsCl(gKYwDaheMddMoOWYVbjOI1bPySsxXGi0bjEfweWyq(zBqcQyDngCDuKdU0kOa7I04uHzvcJqtk2dlr120sofofihWD8fTW2PEPsSq8flxPGlqtCft4uGCSIQHtbjPkgNAstMKmj1fWLIXkDfTATnmyxgwSArjabzC1KMmjzsQlGlfJv6kSBxBMACJKGM8PeB8f8yWOdchJnOJmixPGds8skhKQ4bjEfw1nOWIh0XgjgKXWdu0bbc5bTfHzFdICdktGWbjEfweWyq(zBqcQyDngCDuKdU0kOa7I04uHzvcJqtk2dlrlSDQxQeleFXYvk4Qo7mgEeBQxQeleFXYvk4sbs9OihUBdd2LHfRwucqqgxnPjtsMK6c4sXyLUc721MPg3ijOjFkXg)XGrheGsxXdAllbPuBdICdcabgeFCtXWXGRJICWLwbfyxKS0vCctcsP2eTW2HMSuMcNcKdOD7aG72zqmSvw6koHjbPuBlqZXGRJICWLwbfyxeHlPSoGjOjLzrlSDHCA5zjVYsxXjmjiLAlbTDACfdFmfOTvunCkiPg3i2bqRwqtwktHtbYb0oae8yW1rro4sRGcSlsw6korbHwIwy7c50YZsELLUItysqk1wcA704kg(ykqBROA4uqsnUrSdGwTGMSuMcNcKdODai4XGRJICWLwbfyxefLDvw6kgkAHTVnmyxgwSA5sjUAstMKmj1fqCUJ)yW1rro4sRGcSlc0YveXByPs0cBFByWUmSy1YLsCfYPLNL8YBYGqRKMCQkkYngCDuKdU0kOa7IysIICIwy7zqmSvwsikjimwu21rRwyfqRir5gVoiongEA1kdIHTCfLpxwhNOGqRfO5yW1rro4sRGcSlswsiQegi12yW1rro4sRGcSlsMPqMkCDahdUokYbxAfuGDrWkkNLeIAm46OihCPvqb2fXpnddQltAxkhdgDq2hJ5GYyqyUuMDTWdcJqhei0ZsEqvWnW1yW1rro4sRGcSlciKtvWnqrlSDfNbXWwzoeN5lfwCITXWfOjUIz7WL8flGweyiTLGbTeMx85zjRA1sXzqmSfqlcmK2sWGwcZlqtb3Qfwb0ksuUXRdIZDaWZyymy0bTLRRGwmfogm6Gamm(dICdstisfr8BqbzqcZS5GclEqckTIbP4mig2GanhdUokYbxy1vqR9mhIZ8LcloX2y4yW1rro4cRUcAjWUiqzP5KFQKQ0SOf2EgedBbLLMt(PsQsZlk341bXjwb0ksuUXRdIlLXOm0YZsEm46OihCHvxbTeyxevbn9qBnggdgDq9GDzyngCDuKdUGb7YWAxvqtp0wIwy7AstMKmj1fq721MPg3ijOjFQXGRJICWfmyxgwcSlI3KbHwJbxhf5GlyWUmSeyxeTf7MjOfjevBtl5u4uGCa3Xx0cBpCjFXYKY2sKlfwCsC2fEXNNLSc3TdNcKJvbtzce(Xh)d]] )

end