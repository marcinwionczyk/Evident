function DeleteSurety() {
    return confirm('Czy na pewno chcesz usunąć wybrany wiersz ?');
}

function Warn(sMessage) {
    return alert(sMessage);
}

function PrintPage(printButton) {
    printButton.style.display = "none";
    window.print();
    printButton.style.display = "inline";
    return false;
}
