document.addEventListener("DOMContentLoaded", function () {
  // Load airports for the dropdown menus
  loadAirports();

  // Add event listeners
  document
    .getElementById("search-form")
    .addEventListener("submit", searchFlights);
  document
    .getElementById("booking-form")
    .addEventListener("submit", bookFlight);
  // Close buttons may be multiple (one per modal)
  document
    .querySelectorAll(".modal .close")
    .forEach((btn) => btn.addEventListener("click", closeModal));

  // My Bookings button
  document.getElementById("my-bookings").addEventListener("click", (e) => {
    e.preventDefault();
    openBookingsModal();
  });
});

function loadAirports() {
  fetch("includes/get_airports.php")
    .then((response) => response.json())
    .then((data) => {
      const fromSelect = document.getElementById("from");
      const toSelect = document.getElementById("to");

      data.forEach((airport) => {
        const option = document.createElement("option");
        option.value = airport.AirportId;
        option.textContent = `${airport.AirportCity} (${airport.AirportName})`;

        fromSelect.appendChild(option.cloneNode(true));
        toSelect.appendChild(option);
      });
    })
    .catch((error) => console.error("Error loading airports:", error));
}

function searchFlights(event) {
  event.preventDefault();

  const formData = new FormData(event.target);
  const searchParams = new URLSearchParams(formData);

  fetch("includes/search_flights.php?" + searchParams.toString())
    .then((response) => response.json())
    .then((data) => displayFlightResults(data))
    .catch((error) => console.error("Error searching flights:", error));
}

function displayFlightResults(flights) {
  const resultsContainer = document.getElementById("search-results");
  resultsContainer.innerHTML = "";

  flights.forEach((flight) => {
    const flightCard = document.createElement("div");
    flightCard.className = "flight-card";
    flightCard.innerHTML = `
            <div class="flight-info">
                <h3>${flight.AirlineName}</h3>
                <p>From: ${flight.SourceCity} - To: ${flight.DestinationCity}</p>
                <p>Departure: ${flight.DepartureDateTime}</p>
                <p>Arrival: ${flight.ArrivalDateTime}</p>
                <p>Available Seats: ${flight.AvailableSeats}</p>
            </div>
            <div class="flight-actions">
                <p>Starting from $${flight.MinCost}</p>
                <button onclick="openBookingModal(${flight.FlightId})">Book Now</button>
            </div>
        `;
    resultsContainer.appendChild(flightCard);
  });
}

function openBookingModal(flightId) {
  const modal = document.getElementById("booking-modal");
  modal.style.display = "block";
  modal.dataset.flightId = flightId;

  // Load travel classes for the selected flight
  loadTravelClasses(flightId);
}

function closeModal() {
  document
    .querySelectorAll(".modal")
    .forEach((m) => (m.style.display = "none"));
}

function loadTravelClasses(flightId) {
  fetch(`includes/get_travel_classes.php?flightId=${flightId}`)
    .then((response) => response.json())
    .then((data) => {
      const select = document.getElementById("seat-class");
      select.innerHTML = "";

      data.forEach((travelClass) => {
        const option = document.createElement("option");
        option.value = travelClass.TravelClassId;
        option.textContent = `${travelClass.TravelClassName} - $${travelClass.Cost}`;
        select.appendChild(option);
      });
    })
    .catch((error) => console.error("Error loading travel classes:", error));
}

function bookFlight(event) {
  event.preventDefault();
  const flightId = document.getElementById("booking-modal").dataset.flightId;
  const form = event.target;
  const formData = new FormData();
  // Collect fields explicitly to ensure names match PHP
  formData.append("flightId", flightId);
  formData.append(
    "passenger-first",
    document.getElementById("passenger-first").value
  );
  formData.append(
    "passenger-last",
    document.getElementById("passenger-last").value
  );
  formData.append(
    "passenger-email",
    document.getElementById("passenger-email").value
  );
  formData.append(
    "passenger-phone",
    document.getElementById("passenger-phone").value
  );
  formData.append(
    "passenger-address",
    document.getElementById("passenger-address").value
  );
  formData.append(
    "passenger-city",
    document.getElementById("passenger-city").value
  );
  formData.append(
    "passenger-state",
    document.getElementById("passenger-state").value
  );
  formData.append(
    "passenger-zip",
    document.getElementById("passenger-zip").value
  );
  formData.append(
    "passenger-country",
    document.getElementById("passenger-country").value
  );
  formData.append("seat-class", document.getElementById("seat-class").value);
  // Include optional passenger-id if present
  const pid = document.getElementById("passenger-id").value;
  if (pid) formData.append("passenger-id", pid);

  fetch("includes/book_flight.php", { method: "POST", body: formData })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        alert(
          "Flight booked successfully! Reservation ID: " +
            (data.reservationId || "N/A")
        );
        closeModal();
      } else {
        alert("Error booking flight: " + (data.message || "Unknown"));
      }
    })
    .catch((err) => {
      console.error("Error booking flight:", err);
      alert("Error booking flight, see console for details.");
    });
}

function openBookingsModal() {
  const modal = document.getElementById("bookings-modal");
  modal.style.display = "block";
  // Ask user for email to fetch bookings
  const email = prompt("Enter your email to view bookings:");
  if (!email) return;
  fetch("includes/get_bookings.php?email=" + encodeURIComponent(email))
    .then((r) => r.json())
    .then((data) => {
      const list = document.getElementById("bookings-list");
      list.innerHTML = "";
      if (!data.length) {
        list.textContent = "No bookings found for this email.";
        return;
      }
      data.forEach((b) => {
        const div = document.createElement("div");
        div.className = "booking-item";
        div.innerHTML = `
          <p>Reservation #: ${b.ReservationId}</p>
          <p>Flight: ${b.AirlineName} ${b.SourceCity} -> ${b.DestinationCity}</p>
          <p>Date: ${b.DepartureDateTime}</p>
          <p>Status: ${b.ReservationStatus}</p>
          <button data-reservation-id="${b.ReservationId}" class="cancel-btn">Cancel</button>
        `;
        list.appendChild(div);
      });
      // attach cancel handlers
      list.querySelectorAll(".cancel-btn").forEach((btn) =>
        btn.addEventListener("click", (e) => {
          const id = e.target.dataset.reservationId;
          if (
            !confirm("Are you sure you want to cancel reservation #" + id + "?")
          )
            return;
          const fd = new FormData();
          fd.append("reservationId", id);
          fetch("includes/cancel_flight.php", { method: "POST", body: fd })
            .then((r) => r.json())
            .then((resp) => {
              if (resp.success) {
                alert("Reservation cancelled");
                openBookingsModal(); // refresh
              } else {
                alert("Cancel failed: " + (resp.message || "Unknown"));
              }
            })
            .catch((err) => {
              console.error(err);
              alert("Cancel request failed");
            });
        })
      );
    })
    .catch((err) => {
      console.error(err);
      alert("Failed to load bookings");
    });
}
