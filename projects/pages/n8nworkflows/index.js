
document.addEventListener('DOMContentLoaded', () => {
    const html = document.documentElement;
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    if (savedTheme === 'dark' || (!savedTheme && prefersDark)) {
        html.classList.add('dark');
    }

    const modal = document.getElementById("imageModal");
    const modalImg = document.getElementById("modalImage");
    const span = document.getElementsByClassName("close")[0];

    // Get all images with the class 'enlargeable-image'
    const images = document.querySelectorAll('.enlargeable-image');

    // Loop through all images and add a click event listener
    images.forEach(img => {
        img.onclick = function(){
            modal.style.display = "flex"; // Use flex to show and center
            modalImg.src = this.src;
        }
    });

    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

    // When the user clicks anywhere on the modal background, close it
    modal.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});