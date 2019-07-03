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
        }
    }
}