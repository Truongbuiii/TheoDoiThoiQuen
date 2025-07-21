// Khởi tạo Supabase client
const { createClient } = supabase;

const supabaseUrl = 'https://rfwtdypghflwimnlaboo.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmd3RkeXBnaGZsd2ltbmxhYm9vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwODMzNjUsImV4cCI6MjA2ODY1OTM2NX0.tbnYRzhEOLwlzcwQUIxzTMFMb7ZOwakcl0frrHfbExU';
const db = createClient(supabaseUrl, supabaseKey);

const form = document.getElementById('habit-form');
const habitList = document.getElementById('habit-list');

form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('title').value;
    const description = document.getElementById('description').value;

    const { data, error } = await db.from('thoiquen').insert([{ title, description }]);

    if (!error) {
        alert('Habit added!');
        form.reset();
        loadHabits();
    } else {
        console.error(error);
        alert('Error adding habit.');
    }
});

async function loadHabits() {
    const { data, error } = await db.from('thoiquen').select('*');
    habitList.innerHTML = '';
    if (data) {
        data.forEach((habit) => {
            const li = document.createElement('li');
            li.textContent = `${habit.title}: ${habit.description}`;
            habitList.appendChild(li);
        });
    }
}

loadHabits();
