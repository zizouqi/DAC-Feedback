var LEVEL_ONE_CHESS = '';
function OnShowDrawCard(keys){
    if (!CheckClientKey(keys.key)) return;
    if (keys.unlock == true){
        Game.EmitSound("ui.crafting_newslot");
        IS_PANEL_DRAW_CARD_LOCKED = false;
        $("#image_lock").SetImage("file://{images}/custom_game/unlock.png");
        $("#image_lock").style['opacity'] = '0.1';
    }
    if (keys.auto_unlock == true){
        Game.EmitSound("ui.crafting_newslot");
        IS_PANEL_DRAW_CARD_LOCKED = false;
        $("#image_lock").SetImage("file://{images}/custom_game/unlock.png");
        $("#image_lock").style['opacity'] = '0.1';
        return;
    }
    var cards = keys.cards.split(',');
    LEVEL_ONE_CHESS = keys.level_one_chess;
    MY_DRAW_CHESS_LIST = {};
    if (cards && cards.length>1){
        for (var i=0;i<cards.length;i++){
            if (cards[i]){
                MY_DRAW_CHESS_LIST[i] = cards[i];
            }
        }
    }
    show_panel_draw_card();
    GameUI.SelectUnit( -1, false );
}
function set_draw_card_status(){
    if (MY_DRAW_CHESS_LIST){
        for (var i in MY_DRAW_CHESS_LIST){
            var price = CHESS_2_LEVEL[MY_DRAW_CHESS_LIST[i]];
            var my_gold = MY_GOLD || Math.round(Entities.GetMana(Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())));
            if (price > my_gold){
                $('#text_draw_card_price_'+i).style['color'] = '#ff0000';
            }
            else{
                $('#text_draw_card_price_'+i).style['color'] = '#ffffff';
            }
            if (LEVEL_ONE_CHESS.indexOf(MY_DRAW_CHESS_LIST[i].toString()) >= 0){
                $('#text_draw_card_price_'+i).style['color'] = '#00ff00';
            }
        }
    }
}