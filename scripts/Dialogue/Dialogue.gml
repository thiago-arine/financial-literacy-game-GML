function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
        show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages  =_messages;
    _inst.current_message = 0;
};

char_colors = {
    "Teste NPC": c_fuchsia,
    "Mentor": c_teal
};

dialog_npc = [
    {
        name: "Teste NPC",
        msg: "O diálogo está funcionando"
    }];

dialog_mentor = [
    {
        name: "Mentor",
        msg: "Bem vindo! Sou seu mentor financeiro."
    },
    {
        name: "Mentor",
        msg: "Nossa meta: Construir liberdade finaceira. Você aprenderá a investir e a diferença entre necessidade e desejo. A partir de agora cada escolha é sua."
    },
    {
        name: "Mentor",
        msg: "Ao longo de sua jornada aparecerão oportunidades, além disso, o influenciador digital vai tentar te convencer a seguir por outro caminho."
    },
    {
        name: "Mentor",
        msg: "Vamos começar. Qual é o seu objetivo finaceiro?"
    }];