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
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[0].classList.add("active-sidebar-options");
		
	fetch('doctorDashboard.jsp?opname=appointments')
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});							
}


function loadApptFilterDashboard(id) {
	fetch('doctorDashboard.jsp?opname=update&apptId=' + id)
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});			
}


function visitedUpdate(id, button_type) {
	fetch('doctorDashboard.jsp?opname=update&apptId=' + id + '&button_type=' + button_type)
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});			
}



function loadScheduledAppt() {
	document.getElementById("search-filter").style.display = "none";	
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[1].classList.add("active-sidebar-options");
	
	fetch('scheduled_appointment.jsp?opname=appointments')
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});	
}


function loadApptFilterDashboard2(id) {
	fetch('scheduled_appointment.jsp?opname=update&apptId=' + id)
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});			
}


function visitedUpdate2(id, button_type) {
	fetch('scheduled_appointment.jsp?opname=update&apptId=' + id + '&button_type=' + button_type)
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});			
}



function loadNewAppointments() {
	document.getElementById("search-filter").style.display = "none";	
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[2].classList.add("active-sidebar-options");
	
	fetch('new_Appointments.jsp?opname=appointments')
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});		
}


function loadNewApptFilter(id, action) {	
	fetch('new_Appointments.jsp?opname=update&apptId=' + id + '&action=' + action + '&registered_doctors_email_address=' + sessionStorage.getItem("registered_doctors_email_address"))
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});			
}



function loadPrescription() {
	document.getElementById("search-filter").style.display = "none";	
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[3].classList.add("active-sidebar-options");
		
	fetch('prescription.jsp?opname=prescription')
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});	
}



function loadUpdateRefill() {
	document.getElementById("search-filter").style.display = "none";	
	document.getElementById("search-filter-refill").style.display = "block";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
	
	sidebar_options[4].classList.add("active-sidebar-options");	
	
	let search_filter_refill = document.getElementById("search-filter-refill");
	
	search_filter_refill.addEventListener("keyup", function(event) {
		if (event.key.length > 0) {						
			
			sessionStorage.setItem("prescription_id_filter", event.target.value.trim());
			
			fetch('update_refill.jsp?prescription_id_filter=' + event.target.value)
			.then(response => response.text())
			.then(data => {
				right_body.innerHTML = data;			
			})
			.catch(error => {
				console.error('Error:', error);
			});	
		}
	});	
		
	fetch('update_refill.jsp')
	.then(response => response.text())
	.then(data => {
		right_body.innerHTML = data;			
	})
	.catch(error => {
		console.error('Error:', error);
	});	
}


function loadPrescriptionFilter(id) {
	fetch('update_refill.jsp?prescription_id=' + id + "&prescription_id_filter=" + sessionStorage.getItem("prescription_id_filter"))
		.then(response => response.text())
		.then(data => {
			window.alert("Decremented By 1 Successfully");
			right_body.innerHTML = data;					
		})
		.catch(error => {
			console.error('Error:', error);
		});		
}



function loadPatientList() {	
	document.getElementById("search-filter").style.display = "block";	
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
	
	sidebar_options[5].classList.add("active-sidebar-options");	
	
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



function submitPrescriptionForm(event) {			
	event.preventDefault();	
	const formData = new FormData(event.target);		
	
	fetch('prescription.jsp?' + new URLSearchParams(formData).toString())
	.then(response => response.text())
	.then(data => {
		right_body.innerHTML = data;	
		window.alert("Saved Successfully");		
	})
	.catch(error => {
		console.error('Error:', error);
	});	
	
	return false;
}



function loadApptHistory() {
	document.getElementById("search-filter").style.display = "none";	
	document.getElementById("search-filter-refill").style.display = "none";	
	
	for (let i = 0; i < sidebar_options.length; i++) {
		sidebar_options[i].classList.remove("active-sidebar-options");			
	}
		
	sidebar_options[6].classList.add("active-sidebar-options");
	
	fetch('appointment_history.jsp')
		.then(response => response.text())
		.then(data => {
			right_body.innerHTML = data;			
		})
		.catch(error => {
			console.error('Error:', error);
		});	
}



