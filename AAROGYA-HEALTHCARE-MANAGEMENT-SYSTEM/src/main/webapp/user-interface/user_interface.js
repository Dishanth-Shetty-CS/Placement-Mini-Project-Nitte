let main = document.getElementById("main");
let header = document.getElementById("header");
window.addEventListener("load", function() {
    let header_height = header.offsetHeight;
    main.style.marginTop = header_height + "px";
});

window.addEventListener("resize", function() {
    let header_height = header.offsetHeight;
    main.style.marginTop = header_height + "px";
});

let right_body = document.getElementById("right-body");
let sidebar_options = document.getElementsByClassName("sidebar-options");


function loadDashboard() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[0].classList.add("active-sidebar-options");

    fetch('userDashboard.jsp')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadBookAppt() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[1].classList.add("active-sidebar-options");

    fetch('book_appointment.jsp')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function submitApptFormData(event) {
    event.preventDefault();
    const formData = new FormData(event.target);

    formData.append('registered_users_email_address', sessionStorage.getItem('registered_users_email_address'));

    fetch('book_appointment.jsp?' + new URLSearchParams(formData).toString())
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function cancelAppt(id) {
    fetch('userDashboard.jsp?opname=cancel&apptId=' + id)
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function loadMyAppointments() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[2].classList.add("active-sidebar-options");

    fetch('my_appointments.jsp?registered_users_email_address=' + sessionStorage.getItem('registered_users_email_address'))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function loadPrescription() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[3].classList.add("active-sidebar-options");

    fetch('prescription.jsp?registered_users_email_address=' + sessionStorage.getItem('registered_users_email_address'))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function loadPrescriptionHistory() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[4].classList.add("active-sidebar-options");

    fetch('prescription_history.jsp?registered_users_email_address=' + sessionStorage.getItem('registered_users_email_address'))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function loadApptHistory() {
    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[5].classList.add("active-sidebar-options");

    fetch('appointment_history.jsp?registered_users_email_address=' + sessionStorage.getItem('registered_users_email_address'))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



