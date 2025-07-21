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

    const { data, error } = await db.from('thoiquen').insert([
        { TieuDe: title, mota: description }
    ]);

    if (!error) {
        alert('Thêm thói quen thành công!');
        form.reset();
        loadHabits();
    } else {
        console.error('Lỗi Supabase:', error);
        alert('Lỗi khi thêm thói quen: ' + error.message);
    }
});

async function loadHabits() {
    const { data, error } = await db.from('thoiquen').select('*');
    habitList.innerHTML = '';
    if (data && data.length > 0) {
        data.forEach((habit) => {
            const li = document.createElement('li');
            li.textContent = `${habit.TieuDe}: ${habit.mota}`;
            habitList.appendChild(li);
        });
    } else if (error) {
        console.error(error);
        habitList.innerHTML = '<li>Lỗi khi tải dữ liệu.</li>';
    } else {
        habitList.innerHTML = '<li>Chưa có thói quen nào.</li>';
    }
}

loadHabits();
