<template>
  <div class="civilians-container">
    <div class="header">
      <h2>Civilians</h2>
      <div class="actions">
        <input type="text" v-model="searchQuery" placeholder="Search civilians..." class="search-bar" />
        <button class="create-btn">Create Civilian</button>
      </div>
    </div>
    <table class="civilians-table">
      <thead>
        <tr>
          <th>Name</th>
          <th>Date of Birth</th>
          <th>Notes</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="civilian in filteredCivilians" :key="civilian.id">
          <td>{{ civilian.name }}</td>
          <td>{{ civilian.dob }}</td>
          <td>{{ civilian.notes }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'Civilians',
  data() {
    return {
      searchQuery: '',
      civilians: [],
    }
  },
  computed: {
    filteredCivilians() {
      return this.civilians.filter(civilian => {
        return civilian.name.toLowerCase().includes(this.searchQuery.toLowerCase())
      })
    }
  },
  methods: {
    fetchCivilians() {
      fetch(`https://qb-police-mdt/getCivilians`, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json; charset=UTF-8',
          },
          body: JSON.stringify({})
      }).then(resp => resp.json()).then(resp => console.log(resp));
    },
    handleMessage(event) {
      if (event.data.type === 'receiveCivilians') {
        this.civilians = event.data.data;
      }
    }
  },
  mounted() {
    this.fetchCivilians();
    window.addEventListener('message', this.handleMessage);
  },
  beforeUnmount() {
    window.removeEventListener('message', this.handleMessage);
  }
}
</script>

<style scoped>
.civilians-container {
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

.civilians-table {
  width: 100%;
  border-collapse: collapse;
}

.civilians-table th, .civilians-table td {
  padding: 15px;
  border-bottom: 1px solid #444;
  text-align: left;
}

.civilians-table thead {
  background-color: #25282c;
}
</style>
