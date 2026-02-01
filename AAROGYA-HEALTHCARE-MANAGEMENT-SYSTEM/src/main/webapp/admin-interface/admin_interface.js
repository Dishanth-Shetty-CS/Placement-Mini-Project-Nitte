/*---------------- admin_inteface.html and adminDashboard.jsp ----------------*/

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
    document.getElementById("search-filter").style.display = "none";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[0].classList.add("active-sidebar-options");

    fetch('adminDashboard.jsp?opname=unread')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;

            let container_tabs = document.getElementsByClassName("container-tabs-options");
            container_tabs[0].id = "active-container-tabs";
        })
        .catch(error => {
            console.error('Error:', error);
        });

    sessionStorage.setItem("message-state", "close");
}


function loadDoctorList() {
    document.getElementById("search-filter").style.display = "block";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[1].classList.add("active-sidebar-options");

    let search_filter = document.getElementById("search-filter");

    search_filter.addEventListener("keyup", function(event) {
        if (event.key.length > 0) {

            fetch('doctor_list.jsp?opname=search-filter&email_address=' + event.target.value)
                .then(response => response.text())
                .then(data => {
                    right_body.innerHTML = data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    });

    fetch('doctor_list.jsp?opname=doctor-list')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadAddDoctor() {
    document.getElementById("search-filter").style.display = "none";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[2].classList.add("active-sidebar-options");

    fetch('add_doctor.jsp?opname=add-doctor')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadPatientList() {
    document.getElementById("search-filter").style.display = "block";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[3].classList.add("active-sidebar-options");

    let search_filter = document.getElementById("search-filter");

    search_filter.addEventListener("keyup", function(event) {
        if (event.key.length > 0) {

            fetch('patient_list.jsp?opname=search-filter&email_address=' + event.target.value)
                .then(response => response.text())
                .then(data => {
                    right_body.innerHTML = data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    });

    fetch('patient_list.jsp?opname=patient-list')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadAddPatient() {
    document.getElementById("search-filter").style.display = "none";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[4].classList.add("active-sidebar-options");

    fetch('add_patient.jsp')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadAppointments() {
    document.getElementById("search-filter").style.display = "none";
    document.getElementById("search-user-filter").style.display = "block";
    document.getElementById("search-doctor-filter").style.display = "block";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[5].classList.add("active-sidebar-options");

    fetch('appointments.jsp?opname=appointments')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadAdminList() {
    document.getElementById("search-filter").style.display = "block";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[6].classList.add("active-sidebar-options");

    let search_filter = document.getElementById("search-filter");

    search_filter.addEventListener("keyup", function(event) {
        if (event.key.length > 0) {

            fetch('admin_list.jsp?opname=search-filter&email_address_filter=' + event.target.value + '&email_address=' + sessionStorage.getItem('registered_admins_email_address'))
                .then(response => response.text())
                .then(data => {
                    right_body.innerHTML = data;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    });

    fetch('admin_list.jsp?opname=admin-list&email_address=' + sessionStorage.getItem('registered_admins_email_address'))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function loadAddAdmin() {
    document.getElementById("search-filter").style.display = "none";
    document.getElementById("search-user-filter").style.display = "none";
    document.getElementById("search-doctor-filter").style.display = "none";

    for (let i = 0;i < sidebar_options.length;i++) {
        sidebar_options[i].classList.remove("active-sidebar-options");
    }

    sidebar_options[7].classList.add("active-sidebar-options");

    fetch('add_admin.jsp')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}



function showMessage(obj) {
    if (sessionStorage.getItem("message-state") == "open") {
        return;
    }

    let nextElementRef = document.getElementById(obj.nextElementSibling.id);
    let messageElements = document.getElementsByClassName("message");

    for (let i = 0;i < messageElements.length;i++) {
        if (messageElements[i] === nextElementRef) {
            messageElements[i].style.display = "block";
            break;
        }
    }

    if (obj.classList.contains("fa-envelope")) {
        let envelope = document.getElementsByClassName("fa-envelope");
        for (let i = 0;i < envelope.length;i++) {
            if (envelope[i] === obj) {
                envelope[i].classList.add("fa-envelope-open");
                envelope[i].classList.remove("fa-envelope");
                break;
            }
        }
    }

    sessionStorage.setItem("message-state", "open");
}


function closeMessage(obj) {
    let messageElements = document.getElementsByClassName("message");

    for (let j = 0;j < messageElements.length;j++) {
        messageElements[j].style.display = "none";
    }

    if (obj.id == "unread") {
        fetch('adminDashboard.jsp?opname=unread&qid=' + obj.parentElement.id)
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                let container_tabs = document.getElementsByClassName("container-tabs-options");
                container_tabs[0].id = "active-container-tabs";
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    sessionStorage.setItem("message-state", "close");
}



let container_tabs = document.getElementsByClassName("container-tabs-options");

function loadUnreadQueries() {
    sessionStorage.setItem("container-tab-status", "unread");

    if (!container_tabs[0].id) {
        container_tabs[1].removeAttribute("id");
        container_tabs[0].id = "active-container-tabs";
    }

    fetch('adminDashboard.jsp?opname=unread')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;

            if (sessionStorage.getItem("container-tab-status") == "read") {
                container_tabs[1].id = "active-container-tabs";
            } else {
                container_tabs[0].id = "active-container-tabs";
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function loadReadQueries() {
    sessionStorage.setItem("container-tab-status", "read");

    if (!container_tabs[1].id) {
        container_tabs[0].removeAttribute("id");
        container_tabs[1].id = "active-container-tabs";
    }

    fetch('adminDashboard.jsp?opname=read')
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;

            if (sessionStorage.getItem("container-tab-status") == "read") {
                container_tabs[1].id = "active-container-tabs";
            } else {
                container_tabs[0].id = "active-container-tabs";
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


/*---------------- Doctor List ----------------*/

function deleteDoctor(id) {
    fetch('doctor_list.jsp?opname=deleteDoctor&id=' + id)
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


/*---------------- Patient List ----------------*/

function deletePatient(id) {
    fetch('patient_list.jsp?opname=deletePatient&id=' + id)
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


/*---------------- Appointments ----------------*/

function loadApptsByFilter() {
    let dept = document.getElementById("department-filter");
    let apptStatus = document.getElementById("appointment-filter");
    let search_user_filter = document.getElementById("search-user-filter");
    let search_doctor_filter = document.getElementById("search-doctor-filter");

    sessionStorage.setItem("dept", dept.selectedIndex);
    sessionStorage.setItem("status", apptStatus.selectedIndex);
    sessionStorage.setItem('search_user_filter', search_user_filter.value);
    sessionStorage.setItem('search_doctor_filter', search_doctor_filter.value);

    fetch('appointments.jsp?opname=filter&dept=' + dept.value + '&status=' + apptStatus.value + '&search_user_filter=' + sessionStorage.getItem("search_user_filter") + '&search_doctor_filter=' + sessionStorage.getItem("search_doctor_filter"))
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;

            let dept = document.getElementById("department-filter");
            let apptStatus = document.getElementById("appointment-filter");

            dept.selectedIndex = sessionStorage.getItem("dept");
            apptStatus.selectedIndex = sessionStorage.getItem("status");

        })
        .catch(error => {
            console.error('Error:', error);
        });
}


let search_user_filter = document.getElementById("search-user-filter");
let search_doctor_filter = document.getElementById("search-doctor-filter");

search_user_filter.addEventListener("keyup", function(event) {
    sessionStorage.setItem('search_user_filter', event.target.value);

    if (event.key.length > 0) {
        let dept = document.getElementById("department-filter");
        let apptStatus = document.getElementById("appointment-filter");

        fetch('appointments.jsp?opname=filter&dept=' + dept.value + '&status=' + apptStatus.value + '&search_user_filter=' + sessionStorage.getItem("search_user_filter") + '&search_doctor_filter=' + sessionStorage.getItem("search_doctor_filter"))
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                let dept = document.getElementById("department-filter");
                let apptStatus = document.getElementById("appointment-filter");

                dept.selectedIndex = sessionStorage.getItem("dept");
                apptStatus.selectedIndex = sessionStorage.getItem("status");

            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
});


search_doctor_filter.addEventListener("keyup", function(event) {
    sessionStorage.setItem('search_doctor_filter', event.target.value);

    if (event.key.length > 0) {
        let dept = document.getElementById("department-filter");
        let apptStatus = document.getElementById("appointment-filter");

        fetch('appointments.jsp?opname=filter&dept=' + dept.value + '&status=' + apptStatus.value + '&search_user_filter=' + sessionStorage.getItem("search_user_filter") + '&search_doctor_filter=' + sessionStorage.getItem("search_doctor_filter"))
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                let dept = document.getElementById("department-filter");
                let apptStatus = document.getElementById("appointment-filter");

                dept.selectedIndex = sessionStorage.getItem("dept");
                apptStatus.selectedIndex = sessionStorage.getItem("status");

            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
});


/*---------------- Admin List ----------------*/

function deleteAdmin(id) {
    fetch('admin_list.jsp?opname=deleteAdmin&id=' + id)
        .then(response => response.text())
        .then(data => {
            right_body.innerHTML = data;
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


/*---------------- Add Doctor ----------------*/

function changeSelectorColor(obj) {
    obj.style.color = "rgb(6, 111, 216)";
}


function submitFormData(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const email_address = formData.get('email_address');
    const first_name = formData.get('first_name');
    const last_name = formData.get('last_name');
    const phone_num = formData.get('phone_num');
    const dept = formData.get('dept');
    const password = formData.get('password');
    const confirm_password = formData.get('confirm_password');

    if (password == confirm_password) {
        fetch("add_doctor.jsp?email_address=" + email_address + "&first_name=" + first_name + "&last_name=" + last_name + "&phone_num=" + phone_num + "&password=" + password + "&dept=" + dept)
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                window.alert("Registered Successfully");
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } else {
        document.getElementById("error").style.visibility = "visible";
        return false;
    }
}


/*---------------- Add Admin ----------------*/

function submitAdminFormData(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const email_address = formData.get('email_address');
    const first_name = formData.get('first_name');
    const last_name = formData.get('last_name');
    const phone_num = formData.get('phone_num');
    const password = formData.get('password');
    const confirm_password = formData.get('confirm_password');

    if (password == confirm_password) {
        fetch("add_admin.jsp?email_address=" + email_address + "&first_name=" + first_name + "&last_name=" + last_name + "&phone_num=" + phone_num + "&password=" + password)
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                window.alert("Registered Successfully");
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } else {
        document.getElementById("error").style.visibility = "visible";
        return false;
    }
}


/*---------------- Add Patient ----------------*/

function submitPatientFormData(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const email_address = formData.get('email_address');
    const first_name = formData.get('first_name');
    const last_name = formData.get('last_name');
    const phone_num = formData.get('phone_num');
    const password = formData.get('password');
    const confirm_password = formData.get('confirm_password');

    if (password == confirm_password) {
        fetch("add_patient.jsp?email_address=" + email_address + "&first_name=" + first_name + "&last_name=" + last_name + "&phone_num=" + phone_num + "&password=" + password)
            .then(response => response.text())
            .then(data => {
                right_body.innerHTML = data;

                window.alert("Registered Successfully");
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } else {
        document.getElementById("error").style.visibility = "visible";
        return false;
    }
}
