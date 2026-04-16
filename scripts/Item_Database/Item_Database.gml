function get_item_data(_item_id) {
    switch(_item_id) {
        case "key":
            return { 
                name: "Chave", 
                sprite: spr_item_key, 
                sell_price: 5, 
                type: "special" 
            };
            
        case "headset":
            return { 
                name: "Fone de Ouvido", 
                sprite: spr_item_headset, 
                sell_price: 30, 
                type: "special" 
            };
            
        case "screwdriver":
            return { 
                name: "Chave Inglesa", 
                sprite: spr_item_screwdriver, 
                sell_price: 5, 
                type: "collectible" 
            };
        case "kite":
            return { 
                name: "Pipa", 
                sprite: spr_item_kite, 
                sell_price: 6, 
                type: "collectible" 
            };    
            
        default:
            return { name: "Item", sprite: spr_icon_goal, sell_price: 2, type: "special" };
    }
}