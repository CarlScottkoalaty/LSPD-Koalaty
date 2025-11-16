<template>
  <div v-if="visible" id="app" class="mdt-container">
    <nav class="sidebar">
      <div class="sidebar-header">
        <h3>Police MDT</h3>
      </div>
      <ul class="nav-links">
        <li><a @click="currentView = 'Dashboard'">Dashboard</a></li>
        <li><a @click="currentView = 'Incidents'">Incidents</a></li>
        <li><a @click="currentView = 'Civilians'">Civilians</a></li>
        <li><a @click="currentView = 'Commands'">Commands</a></li>
      </ul>
      <button @click="closeMDT" class="close-btn">Close</button>
    </nav>
    <main class="main-content">
      <component :is="currentViewComponent" />
    </main>
  </div>
</template>

<script>
import Dashboard from './components/Dashboard.vue'
import Incidents from './components/Incidents.vue'
import Civilians from './components/Civilians.vue'
import Commands from './components/Commands.vue'

export default {
  name: 'App',
  components: {
    Dashboard,
    Incidents,
    Civilians,
    Commands,
  },
  data() {
    return {
      currentView: 'Dashboard',
      visible: false,
    }
  },
  computed: {
    currentViewComponent() {
      return this.currentView
    }
  },
  methods: {
    handleMessage(event) {
      if (event.data.type === 'ui') {
        this.visible = event.data.status;
      }
    },
    closeMDT() {
      this.visible = false;
      fetch(`https://qb-police-mdt/closeMDT`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({})
      }).then(resp => resp.json()).then(resp => console.log(resp));
    }
  },
  mounted() {
    window.addEventListener('message', this.handleMessage);
  },
  beforeUnmount() {
    window.removeEventListener('message', this.handleMessage);
  }
}
</script>

<style>
:root {
  --primary-bg: #1a1a1d;
  --secondary-bg: #25282c;
  --primary-text: #c5c6c7;
  --accent-color: #61dafb;
  --border-color: #444;
}

body {
  margin: 0;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background-color: var(--primary-bg);
  color: var(--primary-text);
}

.mdt-container {
  display: flex;
  height: 100vh;
}

.sidebar {
  width: 250px;
  background-color: var(--secondary-bg);
  padding: 20px;
  box-shadow: 2px 0 5px rgba(0,0,0,0.1);
  display: flex;
  flex-direction: column;
}

.sidebar-header h3 {
  color: var(--accent-color);
  text-align: center;
  margin-bottom: 30px;
  font-size: 1.5rem;
}

.nav-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-links li a {
  display: block;
  padding: 15px 20px;
  color: var(--primary-text);
  text-decoration: none;
  border-radius: 5px;
  margin-bottom: 10px;
  transition: background-color 0.3s, color 0.3s;
  cursor: pointer;
}

.nav-links li a:hover,
.nav-links li a.active {
  background-color: var(--accent-color);
  color: var(--primary-bg);
}

.main-content {
  flex-grow: 1;
  padding: 40px;
  overflow-y: auto;
}

.close-btn {
  margin-top: auto;
  padding: 15px;
  background-color: #d9534f;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1rem;
}

.close-btn:hover {
  background-color: #c9302c;
}
</style>
