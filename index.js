document.addEventListener('DOMContentLoaded', () => {
            const mobileMenuButton = document.getElementById('mobile-menu-button');
            const mobileMenu = document.getElementById('mobile-menu');
            const toggleSwitches = document.querySelectorAll('.dark-mode-toggle');
            const html = document.documentElement;
            const mainContent = document.getElementById('main-content');
            const scrollIndicator = document.getElementById('scroll-indicator');

            // --- Theme Toggling ---
            const applyTheme = (theme) => {
                if (theme === 'dark') {
                    html.classList.add('dark');
                } else {
                    html.classList.remove('dark');
                }
                toggleSwitches.forEach(toggle => toggle.checked = (theme === 'dark'));
            };

            toggleSwitches.forEach(toggle => {
                toggle.addEventListener('change', (e) => {
                    const newTheme = e.target.checked ? 'dark' : 'light';
                    localStorage.setItem('theme', newTheme);
                    applyTheme(newTheme);
                    // Re-initialize particles with new colors
                    if(window.particleSystem) window.particleSystem.init();
                });
            });

            // --- Initial Theme Load ---
            const savedTheme = localStorage.getItem('theme');
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            
            if (savedTheme) {
                applyTheme(savedTheme);
            } else if (prefersDark) {
                applyTheme('dark');
            } else {
                applyTheme('light');
            }

            // --- Mobile Menu ---
            mobileMenuButton.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });

            document.querySelectorAll('#mobile-menu a, header nav a').forEach(link => {
                link.addEventListener('click', () => {
                    if (window.innerWidth < 768) {
                        mobileMenu.classList.add('hidden');
                    }
                });
            });

            // --- Contact Bubble Interaction ---
            // const contactContainer = document.getElementById('contact-container');
            // contactContainer.addEventListener('click', () => {
            //     if ('ontouchstart' in window) {
            //         contactContainer.classList.toggle('active');
            //     }
            // });

            // --- Toggle Projects ---
            const toggleBtn = document.getElementById('toggle-projects-btn');
            const projectsWrapper = document.getElementById('projects-wrapper');
            
            if (toggleBtn && projectsWrapper) {
                projectsWrapper.classList.add('projects-collapsed');
                toggleBtn.addEventListener('click', () => {
                    const isCollapsed = projectsWrapper.classList.contains('projects-collapsed');
                    if (isCollapsed) {
                        projectsWrapper.classList.remove('projects-collapsed');
                        projectsWrapper.classList.add('projects-expanded');
                        toggleBtn.textContent = 'Show Less';
                    } else {
                        projectsWrapper.classList.add('projects-collapsed');
                        projectsWrapper.classList.remove('projects-expanded');
                        toggleBtn.textContent = 'Show More';
                    }
                });
            }

            // --- Scroll to Reveal ---
            const handleScroll = () => {
                if (window.scrollY > 50) {
                    mainContent.classList.add('loaded');
                    scrollIndicator.style.display = 'none';
                    window.removeEventListener('scroll', handleScroll);
                }
            };
            window.addEventListener('scroll', handleScroll);

            // --- Cursor Glow Effect ---
            const cursorGlow = document.getElementById('cursor-glow');
            if (cursorGlow) {
                window.addEventListener('mousemove', (e) => {
                    cursorGlow.style.left = `${e.clientX}px`;
                    cursorGlow.style.top = `${e.clientY}px`;
                });
                document.body.addEventListener('mouseenter', () => { cursorGlow.style.opacity = '1'; });
                document.body.addEventListener('mouseleave', () => { cursorGlow.style.opacity = '0'; });
            }

            // --- Particle System ---
            const canvas = document.getElementById('particle-canvas');
            if(canvas) {
                const ctx = canvas.getContext('2d');
                let particles = [];

                window.particleSystem = {
                    init: function() {
                        canvas.width = window.innerWidth;
                        canvas.height = window.innerHeight;
                        particles = [];
                        let numberOfParticles = (canvas.width * canvas.height) / 9000;
                        for (let i = 0; i < numberOfParticles; i++) {
                            let size = Math.random() * 1.5 + 1;
                            let x = Math.random() * (innerWidth - size * 2) + size;
                            let y = Math.random() * (innerHeight - size * 2) + size;
                            let directionX = (Math.random() * .4) - .2;
                            let directionY = (Math.random() * .4) - .2;
                            let color = document.documentElement.classList.contains('dark') ? 'rgba(129, 140, 248, 0.6)' : 'rgba(59, 130, 246, 0.4)';
                            particles.push({ x, y, directionX, directionY, size, color });
                        }
                    },
                    animate: function() {
                        requestAnimationFrame(this.animate.bind(this));
                        ctx.clearRect(0, 0, innerWidth, innerHeight);

                        for (let i = 0; i < particles.length; i++) {
                            let particle = particles[i];
                            particle.x += particle.directionX;
                            particle.y += particle.directionY;

                            // Wall collision
                            if (particle.x + particle.size > canvas.width || particle.x - particle.size < 0) {
                                particle.directionX = -particle.directionX;
                            }
                            if (particle.y + particle.size > canvas.height || particle.y - particle.size < 0) {
                                particle.directionY = -particle.directionY;
                            }
                            // Draw particle
                            ctx.beginPath();
                            ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2, false);
                            ctx.fillStyle = particle.color;
                            ctx.fill();
                        }
                    }
                };
                
                window.addEventListener('resize', () => {
                    window.particleSystem.init();
                });

                window.particleSystem.init();
                window.particleSystem.animate();
            }
        });