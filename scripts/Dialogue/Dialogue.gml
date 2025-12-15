function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
        show_debug_message("criando dialogo")
    var _inst = instance_create_depth(0,0,0, obj_dialog);
    _inst.messages  =_messages;
    _inst.current_message = 0;
};

char_colors = {
    "Teste NPC": c_fuchsia,
    "Mentor": c_teal,
	options: c_red
};

dialog_npc = [
    {
        name: "Teste NPC",
        msg: "O diálogo está funcionando",
		is_question: false
    }];

dialog_mentor = [
    {
        name: "Mentor",
        msg: "Bem vindo! Sou seu mentor financeiro.",
		is_question: false
    },
    {
        name: "Mentor",
        msg: "Nossa meta: Construir liberdade finaceira. Você aprenderá a investir e a diferença entre necessidade e desejo. A partir de agora cada escolha é sua.",
		is_question: false
    },
    {
        name: "Mentor",
        msg: "Ao longo de sua jornada aparecerão oportunidades, além disso, o influenciador digital vai tentar te convencer a seguir por outro caminho.",
		is_question: false
    },
    {
        name: "Mentor",
        msg: "Vamos começar. Qual é o seu objetivo finaceiro?",
		is_question: true,
		options: ["Comprar um celular", "Pagar minha viagem de formatura", "Bancar meu intercâmbio"],
		option_results: [1, 2, 3],
		choice: "meta"
    },
	{
		name: "Mentor",
		msg: "Ótimo! Agora que já deifniu a sua meta, vamos ao que interessa: como cumpri-la.",
		is_question: false
	}];