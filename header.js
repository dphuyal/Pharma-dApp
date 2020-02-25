const header=document.querySelector("header");

const header_content= `
                        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02"
                                aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            
                            <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
                                <a class="navbar-brand" href="#"><strong>PrescriptionTracker</strong></a>
                                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                                    <li class="nav-item active">
                                        <a class="nav-link" href="index.html">Doctor<span class="sr-only">(current)</span></a>
                                    </li>
                                    <li class="nav-item active">
                                        <a class="nav-link" href="patient.html">Patient<span class="sr-only">(current)</span></a>
                                    </li>
                                    <li class="nav-item active">
                                        <a class="nav-link" href="results.html">Prescription Analysis<span class="sr-only">(current)</span></a>
                                    </li>
                                </ul>
                            </div>
                        </nav>`;
header.innerHTML=header_content;