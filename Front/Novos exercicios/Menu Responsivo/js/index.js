(function() {
    const menu = document.querySelector('.menu');
    const hamburger = document.querySelector('.hamburger');

    hamburger.onclick = () => {
        menu.classList.toggle('opened');
    }
}) ();