// Khởi tạo Supabase client
const { createClient } = supabase;

const supabaseUrl = 'https://rfwtdypghflwimnlaboo.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJmd3RkeXBnaGZsd2ltbmxhYm9vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwODMzNjUsImV4cCI6MjA2ODY1OTM2NX0.tbnYRzhEOLwlzcwQUIxzTMFMb7ZOwakcl0frrHfbExU';
const db = createClient(supabaseUrl, supabaseKey);

// DOM elements
const form = document.getElementById('habit-form');
const habitList = document.getElementById('habit-list');

// Thêm thói quen mới
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const title = document.getElementById('title').value;
    const description = document.getElementById('description').value;

    const { data, error } = await db.from('ThoiQuen').insert([
        { TieuDe: title, MoTa: description }
    ]);

    if (!error) {
        alert('Thêm thói quen thành công!');
        form.reset();
        loadHabits();
    } else {
        console.error(error);
        alert('Lỗi khi thêm thói quen.');
    }
});

// Tải danh sách thói quen
async function loadHabits() {
    const { data, error } = await db.from('ThoiQuen').select('*');
    habitList.innerHTML = '';
    if (data && data.length > 0) {
        data.forEach((habit) => {
            const li = document.createElement('li');
            li.textContent = `${habit.TieuDe}: ${habit.MoTa}`;
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
