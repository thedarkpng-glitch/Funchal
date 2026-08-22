--[[

    $$$$$$$\                      $$\              $$$$$$\    p              $$\                     
    $$  __$$\                     $$ |            $$  __$$\                 $$ |                    
    $$ |  $$ | $$$$$$\   $$$$$$$\ $$ |  $$\       $$ /  \__| $$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$$\ 
    $$ |  $$ |$$  __$$\ $$  _____|$$ | $$  |      $$ |      $$  __$$\ $$  __$$ |$$  __$$\ $$  _____|
    $$ |  $$ |$$$$$$$$ |\$$$$$$\  $$$$$$  /       $$ |      $$ /  $$ |$$ /  $$ |$$$$$$$$ |\$$$$$$\  
    $$ |  $$ |$$   ____| \____$$\ $$  _$$<        $$ |  $$\ $$ |  $$ |$$ |  $$ |$$   ____| \____$$\ 
    $$$$$$$  |\$$$$$$$\ $$$$$$$  |$$ | \$$\       \$$$$$$  |\$$$$$$  |\$$$$$$$ |\$$$$$$$\ $$$$$$$  |
    \_______/  \_______|\_______/ \__|  \__|       \______/  \______/  \_______| \_______|\_______/ 
                                                                                                                                                                                                                                                                                                                                                                      
]] 

config = {
    ['gerais'] = {
        ['mensagem'] = true,
        ['language'] = "pt-BR",
        ['color'] = {128, 91, 166},
    },

    ['cards'] = {
        {acl = 'Fundador', file = 'Fundador'};
        {acl = 'Gang', file = 'Gang'};
        {acl = 'Policial', file = 'Policial'};
        {acl = 'Premium', file = 'Premium'};
        {acl = 'Samu', file = 'Samu'};
        {acl = 'Staff', file = 'Staff'};
        {acl = 'Everyone', file = 'Nenhum'};
    },

}


info = {
    ['warning'] = "warning",
    ['success'] = "success",
    ['error'] = "error",
    ['info'] = "info"
};

notify = {
    ['server'] = function(element, message, type)
        return triggerEvent('addBox', element, info[type], message)
    end,

    ['client'] = function(message, type)
        return triggerEvent('addBox', localPlayer, info[type], message)
    end
};