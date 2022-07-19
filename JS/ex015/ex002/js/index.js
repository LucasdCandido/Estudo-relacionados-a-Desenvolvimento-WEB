// function é um procedimento do JavaScript com um conjunto de orientações que executa uma tarefa ou calcula um valor que nesse caso é a tabuada()
function tabuada() {
    // let é uma variavel de escopo interno, mais facil de manipular dentro de funções ou outras estruturas que esta recebendo document da arvore DOM para acessar os elementos do HTML pelo getElementById('txtn')
    let num = document.getElementById('txtn')
    let tab = document.getElementById('seltab')
    // if é uma estrutura de decisão simples, que recebe uma orientação, cujo qual, se ela for verdade, executa um trecho de codigo e se for falso, executa outro trecho
    if (num.value.length == 0) {
        // window é um procedimento do JavaScript para acessar todas as funcionalidades e APIs do Java.Script, que nesse caso esta ultilizando o metodo alert para imprimir a msg dentro dos parenteses e aspas simples
        window.alert('Por favor, digite um número!')
    } else {
        // Number é um metodo do JavaScript para identificar o tipo de dado como numerico, escolhendo automaticamente se é inteiro ou real
        let n = Number(num.value)
        let c = 1
        tab.innerHTML = ``
        // while é uma estrutura de repetição que recebe os parametros para fazer o loop até alcançar os parametros pedidos e finalizar o loop criado
        while (c <= 10) {
            let item = document.createElement('option')
            // os crases `` servem para ser utlizado de forma mais eficiente a representação de elementos do JavaScript dentro do resultado
            item.text = `${n} x ${c} = ${n*c}`
            item.value = `tab${c}`
            // appendChild leva em conta a estrutura DOM para determinar a parentalidade dos elementos, que no caso adiciona um item como filho de outro item, como uma estrutura de arvore
            tab.appendChild(item)
            c++
        }
    }

}