function carregar(){
    var msg = window.document.getElementById('msg')
    var img = window.document.getElementById('imagem')
    var corpo = window.document.getElementById('corpo')
    var data = new Date()
    var hora = data.getHours()
    msg.innerHTML = `Agora são ${hora} horas!`
    if (hora >= 0 && hora < 12) {
        msg.innerHTML += `<br>Bom dia!`
        documente.corpo.style.background = 'lightblue'
        img.src = 'img/manha.png'
    } else if (hora >= 12 && hora < 18) {
        msg.innerHTML += `<br>Boa tarde!`
        documente.corpo.style.background = 'lightcyan'
        img.src = 'img/tarde.png'
    } else {
        msg.innerHTML += `<br>Boa noite!`
        documente.corpo.style.background = 'rgb(7, 1, 87)'
        img.src = 'img/noite.png'
    }
}