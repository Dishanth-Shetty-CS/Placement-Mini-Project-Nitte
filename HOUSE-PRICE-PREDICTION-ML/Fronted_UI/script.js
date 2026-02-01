const API_URL = "http://127.0.0.1:5000";
const form = document.getElementById("predictionForm");
const resultSection = document.getElementById("resultSection");
const predictedPrice = document.getElementById("predictedPrice");
const loadingSpinner = document.getElementById("loadingSpinner");
const inputs = form.querySelectorAll("input[type='number']");
const selects = form.querySelectorAll("select");
const navLinks = document.querySelectorAll('.nav-links a');
const navbarHeight = document.querySelector('.navbar').offsetHeight;

function validateInput(input) {
    const min = parseInt(input.getAttribute("data-min"));
    const max = parseInt(input.getAttribute("data-max"));
    const value = parseInt(input.value);
    const errorText = input.nextElementSibling;

    if (input.value === "" || isNaN(value) || value < min || value > max) {
        input.classList.add("invalid");
        if (errorText) errorText.style.display = "block";
        return false;
    } else {
        input.classList.remove("invalid");
        if (errorText) errorText.style.display = "none";
        return true;
    }
}

inputs.forEach(input => {
    input.addEventListener("input", () => validateInput(input));
    input.addEventListener("blur", () => validateInput(input));
});

function validateSelect(select) {
    const value = select.value;
    const errorText = select.nextElementSibling;

    if (value === "") {
        select.classList.add("invalid");
        if (errorText) errorText.style.display = "block";
        return false;
    } else {
        select.classList.remove("invalid");
        if (errorText) errorText.style.display = "none";
        return true;
    }
}

selects.forEach(select => {
    select.addEventListener("change", () => validateSelect(select));
    select.addEventListener("blur", () => validateSelect(select));
});

form.addEventListener("submit", async (e) => {
    e.preventDefault();

    let isFormValid = true;
    inputs.forEach(input => {
        if (!validateInput(input)) isFormValid = false;
    });
    selects.forEach(select => {
        if (!validateSelect(select)) isFormValid = false;
    });

    if (!isFormValid) return;
    const data = {
        area: Number(document.getElementById("area").value),
        bedrooms: Number(document.getElementById("bedrooms").value),
        bathrooms: Number(document.getElementById("bathrooms").value),
        stories: Number(document.getElementById("stories").value),
        parking: Number(document.getElementById("parking").value),
        has_pool: document.getElementById("has_pool").value,
        has_garage: document.getElementById("has_garage").value,
        has_ac: document.getElementById("has_ac").value
    };
    loadingSpinner.classList.remove("hidden");
    resultSection.classList.add("hidden");

    try {
        const response = await fetch(`${API_URL}/predict`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        });

        if (!response.ok) throw new Error("Server not responding");

        const result = await response.json();

        setTimeout(() => {
            predictedPrice.textContent = result.predicted_price.toLocaleString('en-IN');
            resultSection.classList.remove("hidden");
            loadingSpinner.classList.add("hidden");
            resultSection.scrollIntoView({ behavior: 'smooth' });
        }, 1000);

    } catch (error) {
        loadingSpinner.classList.add("hidden");
        console.error("Connection Error:", error.message);
    }
});
function resetForm() {
    form.reset();
    inputs.forEach(input => input.classList.remove("invalid"));
    selects.forEach(select => select.classList.remove("invalid"));
    resultSection.classList.add("hidden");
    window.scrollTo({ top: 0, behavior: "smooth" });
}

navLinks.forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        navLinks.forEach(l => l.classList.remove('active'));
        link.classList.add('active');

        const targetId = link.getAttribute('href').substring(1);

        if (targetId === "home") {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        } else {
            const targetSection = document.getElementById(targetId);
            if (targetSection) {
                const sectionPosition = targetSection.offsetTop - navbarHeight;
                window.scrollTo({ top: sectionPosition, behavior: 'smooth' });
            }
        }
    });
});