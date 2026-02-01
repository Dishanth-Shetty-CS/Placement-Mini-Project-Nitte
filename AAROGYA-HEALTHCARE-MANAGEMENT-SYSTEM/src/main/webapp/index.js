/*========= Index =========*/

//Sets the offset for the scroll padding
const index_header = document.getElementById("index-header");
if (index_header) {
    window.addEventListener("scroll", function() {
        var headerHeight = index_header.offsetHeight;
        document.documentElement.style.setProperty("--adjust-scroll", headerHeight + "px");
    });
}



//Sets the offset for index heading tag "top" property
const contact_header = document.getElementById("contact-header");
if (contact_header) {
    window.addEventListener("load", function() {
        var contact_header_height = contact_header.offsetHeight;
        document.documentElement.style.setProperty("--adjust-heading-top", contact_header_height + "px");
    });

    window.addEventListener("scroll", function() {
        var contact_header_height = contact_header.offsetHeight;
        const scrolledPosition = window.scrollY;

        if (scrolledPosition >= 100) {
            document.documentElement.style.setProperty("--adjust-heading-top", "0px");
        } else if (scrolledPosition < 100) {
            document.documentElement.style.setProperty("--adjust-heading-top", contact_header_height + "px");
        }
    });
}



//Making Page-Up button visible
const page_up = document.getElementById('page-up');
if (page_up) {
    window.addEventListener('scroll', () => {
        page_up.style.transition = "all 0.2s ease-in-out";
        const scrolledPosition = window.scrollY;

        if (scrolledPosition >= 100) {
            page_up.style.visibility = "visible";
            page_up.style.opacity = "1";
        } else if (scrolledPosition < 100) {
            page_up.style.visibility = "hidden";
            page_up.style.opacity = "0";
        }
    });
}



function submitQueries(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const name = formData.get("name");
    const email_address = formData.get("email_address");
    const subject = formData.get("subject");
    const message = formData.get("message");

    fetch("index.jsp?email_address=" + email_address + "&name=" + name + "&subject=" + subject + "&message=" + message);
    window.alert("Sent Successfully");
    window.location.reload();
}



/*========= Patient Login =========*/

//Sets the login form to the center of the viewport vertically 
const login_main = document.getElementById('login-main');
if (login_main) {
    const header = document.getElementById("header");
    window.addEventListener("load", function() {
        var headerHeight = header.offsetHeight;
        var loginMainHeight = login_main.offsetHeight;
        var remainingViewH = window.innerHeight - loginMainHeight - headerHeight;

        login_main.style.marginTop = headerHeight + "px";

        login_main.style.paddingTop = (remainingViewH / 2) + "px";
        login_main.style.paddingBottom = (remainingViewH / 2) + "px";
    });

    window.addEventListener("resize", function() {
        var headerHeight = header.offsetHeight;
        var loginMainHeight = login_main.offsetHeight;
        var remainingViewH = window.innerHeight - loginMainHeight - headerHeight;

        login_main.style.marginTop = headerHeight + "px";

        login_main.style.paddingTop = (remainingViewH / 2) + "px";
        login_main.style.paddingBottom = (remainingViewH / 2) + "px";
    });
}



function verifyAdminLogin(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const user_table = 'registered_admins';
    const redirect_to = '../admin-interface/admin_interface.html';
    const email_address = formData.get("email_address");
    const password = formData.get("password");

    sessionStorage.setItem('registered_admins_email_address', email_address)

    fetch('verify_login.jsp?email_address=' + email_address + '&password=' + password + '&redirect_to=' + redirect_to + '&user_table=' + user_table, {
        method: 'POST'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                return false;
            } else {
                sessionStorage.setItem("current_user", email_address.trim());
                window.location.replace(data);
            }
        });
}



function verifyDoctorLogin(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const user_table = 'registered_doctors';
    const redirect_to = '../doctor-interface/doctor_interface.html';
    const email_address = formData.get("email_address");
    const password = formData.get("password");

    sessionStorage.setItem('registered_doctors_email_address', email_address)

    fetch('verify_login.jsp?email_address=' + email_address + '&password=' + password + '&redirect_to=' + redirect_to + '&user_table=' + user_table, {
        method: 'POST'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                return false;
            } else {
                sessionStorage.setItem("current_user", email_address.trim());
                window.location.replace(data);
            }
        });
}



function verifyUserLogin(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    const user_table = 'registered_users';
    const redirect_to = '../user-interface/user_interface.html';
    const email_address = formData.get("email_address");
    const password = formData.get("password");

    sessionStorage.setItem('registered_users_email_address', email_address)

    fetch('verify_login.jsp?email_address=' + email_address + '&password=' + password + '&redirect_to=' + redirect_to + '&user_table=' + user_table, {
        method: 'POST'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                return false;
            } else {
                sessionStorage.setItem("current_user", email_address.trim());
                window.location.replace(data);
            }
        });
}



function sendAdminOTP(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    let email_address = formData.get("email_address");
    sessionStorage.setItem('user_table', 'registered_admins');
    sessionStorage.setItem('email_address', email_address);

    formData.append('user_table', 'registered_admins');
    formData.append('email_address', email_address);

    const url = '../sendOTP?' + new URLSearchParams(formData).toString();

    document.getElementById("sending-email").style.display = "block";
    document.getElementById("error").style.visibility = "hidden";

    fetch(url, {
        method: 'GET'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                document.getElementById("sending-email").style.display = "none";
                return false;
            } else {
                window.location.href = data;
            }
        });
}


function sendDoctorOTP(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    let email_address = formData.get("email_address");
    sessionStorage.setItem('user_table', 'registered_doctors');
    sessionStorage.setItem('email_address', email_address);

    formData.append('user_table', 'registered_doctors');
    formData.append('email_address', email_address);

    const url = '../sendOTP?' + new URLSearchParams(formData).toString();

    document.getElementById("sending-email").style.display = "block";
    document.getElementById("error").style.visibility = "hidden";

    fetch(url, {
        method: 'GET'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                document.getElementById("sending-email").style.display = "none";
                return false;
            } else {
                window.location.href = data;
            }
        });
}


function sendUserOTP(event) {
    event.preventDefault();

    const formData = new FormData(event.target);

    let email_address = formData.get("email_address");
    sessionStorage.setItem('user_table', 'registered_users');
    sessionStorage.setItem('email_address', email_address);

    formData.append('user_table', 'registered_users');
    formData.append('email_address', email_address);

    const url = '../sendOTP?' + new URLSearchParams(formData).toString();

    document.getElementById("sending-email").style.display = "block";
    document.getElementById("error").style.visibility = "hidden";

    fetch(url, {
        method: 'GET'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                document.getElementById("sending-email").style.display = "none";
                return false;
            } else {
                window.location.href = data;
            }
        });
}


function resendOTP() {

    var user_table = sessionStorage.getItem("user_table")
    var email_address = sessionStorage.getItem('email_address');

    document.getElementById("sending-email").style.display = "block";
    document.getElementById("error").style.visibility = "hidden";

    const url = '../sendOTP?email_address=' + email_address + "&user_table=" + user_table;

    fetch(url, {
        method: 'GET'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                document.getElementById("sending-email").style.display = "none";
                return false;
            } else {
                window.location.href = data;
            }
        });
}


function verifyOTP(event) {
    event.preventDefault();

    const formData = new FormData(event.target);
    formData.append('verification_code', formData.get("verification_code"));

    const url = '../verifyOTP?' + new URLSearchParams(formData).toString();

    fetch(url, {
        method: 'GET'
    })
        .then(response => response.text())
        .then(data => {
            if (data.includes("Incorrect")) {
                document.getElementById("error").style.visibility = "visible";
                return false;
            } else {
                window.location.href = data;
            }
        });
}



function changePassword(event) {
    event.preventDefault();
    const formData = new FormData(event.target);

    if (formData.get("password") == formData.get("confirm_password")) {

        var redirect_to;
        if (sessionStorage.getItem("user_table") == "registered_admins") {
            redirect_to = "admin_login.html";
        } else if (sessionStorage.getItem("user_table") == "registered_doctors") {
            redirect_to = "doctor_login.html";
        } else if (sessionStorage.getItem("user_table") == "registered_users") {
            redirect_to = "patient_login.html";
        }

        formData.append('user_table', sessionStorage.getItem("user_table"));
        formData.append('email_address', sessionStorage.getItem("email_address"));

        const url = 'change_password.jsp?' + new URLSearchParams(formData).toString();

        fetch(url, {
            method: 'GET'
        })
            .then(() => {
                window.location.href = redirect_to;
            });

    } else {
        document.getElementById("error").style.visibility = "visible";
        return false;
    }
}



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
        fetch("patient_register.jsp?email_address=" + email_address + "&first_name=" + first_name + "&last_name=" + last_name + "&phone_num=" + phone_num + "&password=" + password)
            .then(response => response.text())
            .then(data => {
                if (data.includes("Incorrect")) {
                    document.getElementById("error").style.display = "none";
                    document.getElementById("email_error").style.display = "block";
                } else {
                    window.alert("Registered Successfully");
                    window.location.href = "patient_login.html";
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } else {
        document.getElementById("email_error").style.display = "none";
        document.getElementById("error").style.display = "block";
        document.getElementById("error").style.visibility = "visible";
        return false;
    }
}