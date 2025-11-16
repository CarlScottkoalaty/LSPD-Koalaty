<template>
  <div class="incidents-container">
    <div class="header">
      <h2>Incidents</h2>
      <div class="actions">
        <input type="text" v-model="searchQuery" placeholder="Search incidents..." class="search-bar" />
        <button class="create-btn">Create Incident</button>
      </div>
    </div>
    <table class="incidents-table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Status</th>
          <th>Assigned Officer</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="incident in filteredIncidents" :key="incident.id">
          <td>{{ incident.id }}</td>
          <td>{{ incident.title }}</td>
          <td>{{ incident.status }}</td>
          <td>{{ incident.officer }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'Incidents',
  data() {
    return {
      searchQuery: '',
      incidents: [],
    }
  },
  computed: {
    filteredIncidents() {
      return this.incidents.filter(incident => {
        return incident.title.toLowerCase().includes(this.searchQuery.toLowerCase())
      })
    }
  },
  methods: {
    fetchIncidents() {
      fetch(`https://qb-police-mdt/getIncidents`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({})
      }).then(resp => resp.json()).then(resp => console.log(resp));
    },
    handleMessage(event) {
      if (event.data.type === 'receiveIncidents') {
        this.incidents = event.data.data;
      }
    }
  },
  mounted() {
    this.fetchIncidents();
    window.addEventListener('message', this.handleMessage);
  },
  beforeUnmount() {
    window.removeEventListener('message', this.handleMessage);
  }
}
</script>

<style scoped>
.incidents-container {
  color: #c5c6c7;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.actions {
  display: flex;
  gap: 15px;
}

.search-bar {
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #444;
  background-color: #25282c;
  color: #c5c6c7;
}

.create-btn {
  padding: 10px 15px;
  border-radius: 5px;
  background-color: #61dafb;
  color: #1a1a1d;
  border: none;
  cursor: pointer;
  font-weight: bold;
}

.incidents-table {
  width: 100%;
  border-collapse: collapse;
}

.incidents-table th, .incidents-table td {
  padding: 15px;
  border-bottom: 1px solid #444;
  text-align: left;
}

.incidents-table thead {
  background-color: #25282c;
}
</style>
