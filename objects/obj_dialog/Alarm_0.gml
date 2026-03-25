for (current_dialog = 0; current_dialog < array_length(messages); current_dialog++) {
    if (messages[current_dialog].happened == false) {
        _str = messages[current_dialog];
        current_message = 0; // Inicia a primeira frase do bloco
        break;
    }
}